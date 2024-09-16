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
    func isPhotoInFavorites(by id: String) -> Bool
}

// MARK: - this protocol provides access for work with presenter to view and view controller
protocol FavoritePresenterDelegate: AnyObject {
    var view: FavoriteViewProtocol { get }
    func loadPresenter(controller: UIViewControllerProtocol)
    func transmitInformation(_ data: PhotoInfoModel)
}

final class FavoritePresenter {
    // MARK: - internal protocol properties
    internal var view: FavoriteViewProtocol
    
    // MARK: - private properties
    private let model: FavoriteModelProtocol
    private var infoPresenter: InfoPresenterProtocol?
    private weak var controller: UIViewControllerProtocol?
    
    // MARK: - initialization
    struct Dependencies {
        let model: FavoriteModelProtocol
        let view: FavoriteViewProtocol
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.view = dependencies.view
        self.view.setupFavoritePresenter(self)
    }
    
    // MARK: - method that sends actual information for table cell
    private func updateView() {
        let dataToUpdate = model.getPhotosData
        view.updateCellData(with: dataToUpdate)
    }
}

// MARK: - data update implementation
extension FavoritePresenter: FavoritePresenterProtocol {
    // MARK: - method that tells favoriteModel to add the photo to the collection
    func updateData(_ data: PhotoInfoModel) {
        model.addPhoto(by: data)
        updateView()
    }
    
    // MARK: - method that tells favoriteModel to remove photo
    func removeData(_ id: String) {
        model.removePhoto(by: id)
        updateView()
    }
    
    // MARK: - method that tells favoriteModel to get photo availability in the collection
    func isPhotoInFavorites(by id: String) -> Bool {
        model.isPhotoInFavorites(by: id)
    }
    
    // MARK: - method that sets the connection between infoPresenter and favoritePresenter
    func setupInfoPresenter(_ presenter: InfoPresenterProtocol) {
        self.infoPresenter = presenter
    }
}

extension FavoritePresenter: FavoritePresenterDelegate {
    // MARK: - presenter initialization for controller
    func loadPresenter(controller: UIViewControllerProtocol) {
        self.controller = controller
    }
    
    // MARK: - method that responds to on cell tap
    func transmitInformation(_ data: PhotoInfoModel) {
        infoPresenter?.loadLikedPhotoInfo(by: data)
        controller?.pushViewController(infoPresenter!.controller!)
    }
}
