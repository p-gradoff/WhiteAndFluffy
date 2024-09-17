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
    // MARK: - internal protocol properties
    internal var controller: UIViewControllerProtocol?
    
    // MARK: - private properties
    private let networkManager: NetworkService
    private var model: PhotoInfoModel?
    private weak var favoritePresenter: FavoritePresenterProtocol?
    private weak var view: InfoViewProtocol?
    
    // MARK: - initialization
    init(favoritePresenter: FavoritePresenterProtocol) {
        self.networkManager = NetworkService()
        self.favoritePresenter = favoritePresenter
        
        favoritePresenter.setupInfoPresenter(self)
    }
}

private extension InfoPresenter {
    // MARK: - sets a dependency between the likeButton and the process of adding to favourites
    private func setupHandlers() {
        view?.likePhoto = { [weak self] isLiked in
            guard let self = self else { return }
            
            self.onLikePhotoTouched(isLiked: isLiked)
        }
    }
    
    // MARK: - responds to a likeButton tap
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
            
            // MARK: - adds photo to favorites
            favoritePresenter?.updateData(data)
        case false:
            // MARK: - removes photo from favorites
            favoritePresenter?.removeData(model.id)
        }
    }
    
    // MARK: - sends a data download request to the NetworkService
    private func loadData() {
        guard let model = model else { return }
        networkManager.setupRequest(id: model.id)
        networkManager.getRequest { [weak self] result in
            guard let self = self else { return }
            
            // MARK: - setups view if success, calls alert if failure
            switch result {
            case .success(let data):
                setupView(with: data)
            case .failure(let error):
                controller?.createAlert(
                    title: ErrorHeader.dataError.rawValue,
                    text: error.localizedDescription
                )
            }
        }
    }
    
    // MARK: - loads photo and setups photo's information on view
    private func setupView(with infoModel: InfoModel) {
        guard let model = model else { return }
        view?.imageView.sd_setImage(with: model.photoURL, completed: { [weak self] _, error, _, _ in
            guard let self = self else { return }
            
            guard error == nil else {
                controller?.createAlert(
                    title: ErrorHeader.photoError.rawValue,
                    text: error!.localizedDescription
                )
                return
            }
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
    // MARK: - presenter initialization for controller
    func loadPresenter(with view: InfoViewProtocol, controller: UIViewControllerProtocol) {
        self.view = view
        self.controller = controller
        
        setupHandlers()
    }
    
    // MARK: - method that begins view's setup
    func setupPhotoInformation(model: PhotoInfoModel) {
        self.model = model
        loadData()
    }
    
    // MARK: - method for communitaion between favoritePresenter and infoPresenter. Photos that were added to favorites will not be re-uploaded. Their data has been saved
    func loadLikedPhotoInfo(by data: PhotoInfoModel) {
        self.model = data
        view?.imageView.image = data.photo
        view?.setupInformation(from: data)
    }
    
    // MARK: - method that checks if the current photo is in the favorites
    func isPhotoInFavorites(by id: String) -> Bool {
        favoritePresenter!.isPhotoInFavorites(by: id)
    }
}
