//
//  InfoPresenter.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import Foundation

protocol InfoPresenterProtocol: AnyObject {
    func loadPresenter(with view: InfoViewProtocol, controller: InfoViewControllerProtocol)
}

final class InfoPresenter {
    private let networkManager: NetworkService
    private let model: PhotoInfoModel
    private weak var view: InfoViewProtocol?
    private weak var controller: InfoViewControllerProtocol?
    
    init(model: PhotoInfoModel) {
        self.model = model
        self.networkManager = NetworkService()
    }
    
    private func setup() {
        setupHandlers()
        setupInformationData()
    }
    
}

private extension InfoPresenter {
    private func setupHandlers() {
        
    }
    
    private func setupInformationData() {
        networkManager.setupRequest(id: model.photoID)
        networkManager.getRequest { result in
            switch result {
            case .success(let success):
                print("success")
            case .failure(let failure):
                print("failure")
            }
        }
    }
}

extension InfoPresenter: InfoPresenterProtocol {
    func loadPresenter(with view: InfoViewProtocol, controller: InfoViewControllerProtocol) {
        self.view = view
        self.controller = controller
        
        self.setup()
    }
}
