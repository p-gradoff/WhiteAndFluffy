//
//  UnsplashPresenter.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UnsplashPhotoPicker

protocol UnsplashPresenterProtocol: AnyObject {
    func loadPresenter(controller: UnsplashViewControllerProtocol)
    func setupInformationScreen(with info: UnsplashPhoto)
}

final class UnsplashPresenter {
    private weak var controller: UnsplashViewControllerProtocol?
}

extension UnsplashPresenter: UnsplashPresenterProtocol {
    func loadPresenter(controller: UnsplashViewControllerProtocol) {
        self.controller = controller
    }
    
    func setupInformationScreen(with photo: UnsplashPhoto) {
        let infoViewController = Builder.buildInformationViewController(photo: photo)
        controller?.pushViewController(infoViewController)
    }
}
