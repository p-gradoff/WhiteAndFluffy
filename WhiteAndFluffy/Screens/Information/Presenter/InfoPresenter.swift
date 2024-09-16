//
//  InfoPresenter.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit
import SDWebImage

protocol InfoPresenterProtocol: AnyObject {
    func loadPresenter(with view: InfoViewProtocol, controller: UIViewControllerProtocol)
    func loadLikedPhotoInfo(by data: PhotoInfoModel)
    func setupPhotoInformation(model: PhotoInfoModel)
    func isPhotoInFavorites(by id: String) -> Bool
    var controller: UIViewControllerProtocol? { get }
}

final class InfoPresenter {
    private let networkManager: NetworkService
    private var model: PhotoInfoModel?
    private weak var favoritePresenter: FavoritePresenterProtocol?
    private weak var view: InfoViewProtocol?
    var controller: UIViewControllerProtocol?
    
    init(favoritePresenter: FavoritePresenterProtocol) {
        self.networkManager = NetworkService()
        self.favoritePresenter = favoritePresenter
        
        favoritePresenter.setupInfoPresenter(self)
    }
}

private extension InfoPresenter {
    private func setupHandlers() {
        view?.likePhoto = { [weak self] isLiked in
            guard let self = self else { return }
            
            self.onLikePhotoTouched(isLiked: isLiked)
        }
    }
    
    private func onLikePhotoTouched(isLiked: Bool) {
        guard let model = model else { return }
        switch isLiked {
        case true:
            let data = PhotoInfoModel(
                id: model.id,
                photo: view!.imageView.image!,
                photoURL: model.photoURL,
                username: view!.usernameLabel.text ?? DefaultValues.username.rawValue,
                creationDate: model.creationDate ?? DefaultValues.creationDate.rawValue,
                location: model.location ?? DefaultValues.location.rawValue,
                downloadsCount: model.downloadsCount ?? DefaultValues.downloadsCount.rawValue,
                isLiked: isLiked
            )
            favoritePresenter?.updateData(data)
        case false:
            favoritePresenter?.removeData(model.id)
        }
    }
    
    private func loadData() {
        guard let model = model else { return }
        networkManager.setupRequest(id: model.id)
        networkManager.getRequest { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                setupView(with: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupView(with infoModel: InfoModel) {
        guard let model = model else { return }
        view?.imageView.sd_setImage(with: model.photoURL, completed: { [weak self] _, error, _, _ in
            // TODO: error handling
            guard let self = self else { return }
            view?.activateConstraints()
            
            let creationDate = infoModel.createdAt?.getDate()
            let data = PhotoInfoModel(
                id: model.id,
                photo: view?.imageView.image,
                photoURL: model.photoURL,
                username: infoModel.user?.name,
                creationDate: creationDate,
                location: infoModel.user?.location,
                downloadsCount: String(infoModel.downloads ?? 0),
                isLiked: self.model?.isLiked ?? false
            )
            self.model = data
            view?.setupInformation(from: data)
        })
    }
}

extension InfoPresenter: InfoPresenterProtocol {
    func loadPresenter(with view: InfoViewProtocol, controller: UIViewControllerProtocol) {
        self.view = view
        self.controller = controller
        
        setupHandlers()
    }
    
    func setupPhotoInformation(model: PhotoInfoModel) {
        self.model = model
        loadData()
    }
    
    func loadLikedPhotoInfo(by data: PhotoInfoModel) {
        view?.imageView.image = data.photo
        view?.setupInformation(from: data)
    }
    
    // MARK: - method that checks if the current photo is in the favorites
    func isPhotoInFavorites(by id: String) -> Bool {
        favoritePresenter!.isPhotoInFavorites(by: id)
    }
}
