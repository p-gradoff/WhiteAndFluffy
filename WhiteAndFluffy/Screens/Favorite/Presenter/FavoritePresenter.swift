//
//  FavoritePresenter.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

// MARK: - this protocol is used to update model & view data
protocol FavoritePresenterProtocol: AnyObject {
    func updateData(_ data: PhotoInfoModel)
    func removeData(_ id: String)
    func setupInfoPresenter(_ presenter: InfoPresenterProtocol)
}

// MARK: - this protocol provides access for work with presenter to view and view controller
protocol FavoritePresenterDelegate: AnyObject {
    var view: FavoriteViewProtocol { get }
    func loadPresenter(controller: UIViewControllerProtocol)
    func transmitInformation(_ data: PhotoInfoModel)
}

final class FavoritePresenter {
    private let model: FavoriteModelProtocol
    private var infoPresenter: InfoPresenterProtocol?
    private weak var controller: UIViewControllerProtocol?
    var view: FavoriteViewProtocol
    
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

// MARK: - data update implementation
extension FavoritePresenter: FavoritePresenterProtocol {
    func updateData(_ data: PhotoInfoModel) {
        model.addPhoto(by: data)
        updateView()
    }
    
    func removeData(_ id: String) {
        model.removePhoto(by: id)
        updateView()
    }
    
    func setupInfoPresenter(_ presenter: InfoPresenterProtocol) {
        self.infoPresenter = presenter
    }
}

// MARK: - work with presenter implementation
extension FavoritePresenter: FavoritePresenterDelegate {
    func loadPresenter(controller: UIViewControllerProtocol) {
        self.controller = controller
    }
    
    func transmitInformation(_ data: PhotoInfoModel) {
        infoPresenter?.loadLikedPhotoInfo(by: data)
        
        controller?.pushViewController(infoPresenter!.controller!)
    }
}
