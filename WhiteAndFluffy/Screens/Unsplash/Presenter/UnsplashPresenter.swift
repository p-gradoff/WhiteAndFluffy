//
//  UnsplashPresenter.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UnsplashPhotoPicker

protocol UnsplashPresenterProtocol: AnyObject {
    func loadPresenter(controller: UIViewControllerProtocol)
    func setupInformationScreen(with info: UnsplashPhoto)
}

final class UnsplashPresenter {
    // MARK: - private properties
    private weak var controller: UIViewControllerProtocol?
    private var infoPresenter: InfoPresenterProtocol
    
    // MARK: - initialization
    init(_ infoPresenter: InfoPresenterProtocol) {
        self.infoPresenter = infoPresenter
    }
}

extension UnsplashPresenter: UnsplashPresenterProtocol {
    // MARK: - presenter initialization for controller
    func loadPresenter(controller: UIViewControllerProtocol) {
        self.controller = controller
    }
    
    // MARK: - method that sends initial information of chosen photo
    func setupInformationScreen(with photo: UnsplashPhoto) {
        let isLiked = infoPresenter.isPhotoInFavorites(by: photo.identifier)
        let photoInfoModel = PhotoInfoModel(
            id: photo.identifier,
            photoURL: photo.urls[.regular],
            isLiked: isLiked
        )
        infoPresenter.setupPhotoInformation(model: photoInfoModel)
        
        controller?.pushViewController(infoPresenter.controller!)
    }
}
