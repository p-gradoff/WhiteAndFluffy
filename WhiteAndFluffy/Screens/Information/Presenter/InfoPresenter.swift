//
//  InfoPresenter.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit
import SDWebImage

protocol InfoPresenterProtocol: AnyObject {
    func loadPresenter(with view: InfoViewProtocol, controller: InfoViewControllerProtocol)
}

final class InfoPresenter {
    private let networkManager: NetworkService
    private let model: PhotoInfoModel
    private let favoritePresenter: FavoritePresenterProtocol
    private weak var view: InfoViewProtocol?
    private weak var controller: InfoViewControllerProtocol?
    
    init(model: PhotoInfoModel, favoritePresenter: FavoritePresenterProtocol) {
        self.model = model
        self.favoritePresenter = favoritePresenter
        self.networkManager = NetworkService()
    }
    
    private func setup() {
        setupHandlers()
        loadData()
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
        switch isLiked {
        case true:
            let data = FavoriteInfoModel(
                id: model.photoID,
                photo: view!.imageView.image!,
                photoURL: model.photoURL,
                username: view!.usernameLabel.text ?? ""
            )
            favoritePresenter.updateData(data)
        case false:
            favoritePresenter.removeData(model.photoID)
        }
    }
    
    private func loadData() {
        networkManager.setupRequest(id: model.photoID)
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
        view?.imageView.sd_setImage(with: model.photoURL, completed: { [weak self] _, error, _, _ in
            // TODO: error handling
            guard let self = self else { return }
            view?.activateConstraints()
            
            let creationDate = infoModel.createdAt?.getDate()
            view?.setupInformation(
                username: infoModel.user?.name ?? "Default name",
                creationDate: creationDate ?? "1970-01-01",
                location: infoModel.user?.location ?? "Moscow",
                downloadsCount: String(infoModel.downloads ?? 0)
            )
        })
    }
}

extension InfoPresenter: InfoPresenterProtocol {
    func loadPresenter(with view: InfoViewProtocol, controller: InfoViewControllerProtocol) {
        self.view = view
        self.controller = controller
        
        self.setup()
    }
}
