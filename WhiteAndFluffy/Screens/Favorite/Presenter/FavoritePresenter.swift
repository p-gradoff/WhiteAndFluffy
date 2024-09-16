//
//  FavoritePresenter.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import Foundation

protocol FavoritePresenterProtocol: AnyObject {
    func updateData(_ data: FavoriteInfoModel)
    func removeData(_ id: String)
    func loadPresenter(controller: FavoriteViewControllerProtocol)
    var view: FavoriteViewProtocol { get }
}

final class FavoritePresenter {
    private let model: FavoriteModelProtocol
    var view: FavoriteViewProtocol
    private weak var controller: FavoriteViewControllerProtocol?
    
    struct Dependencies {
        let model: FavoriteModelProtocol
        let view: FavoriteViewProtocol
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.view = dependencies.view
        self.view.setupFavoritePresenter(self)
    }
    
    private func updateView() {
        let dataToUpdate = model.getPhotosData
        view.updateCellData(with: dataToUpdate)
    }
}

extension FavoritePresenter: FavoritePresenterProtocol {
    func loadPresenter(controller: FavoriteViewControllerProtocol) {
        self.controller = controller
    }
    
    func updateData(_ data: FavoriteInfoModel) {
        model.addPhoto(by: data)
        updateView()
    }
    
    func removeData(_ id: String) {
        model.removePhoto(by: id)
        updateView()
    }
}
