//
//  FavoritePresenter.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import Foundation

protocol FavoritePresenterProtocol: AnyObject {
    func loadPresenter(with view: FavoriteViewProtocol, controller: FavoriteViewControllerProtocol)
}

final class FavoritePresenter {
    private let model: FavoriteModelProtocol
    private weak var view: FavoriteViewProtocol?
    private weak var controller: FavoriteViewControllerProtocol?
    
    struct Dependencies {
        let model: FavoriteModelProtocol
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
    }
}

extension FavoritePresenter: FavoritePresenterProtocol {
    func loadPresenter(with view: FavoriteViewProtocol, controller: FavoriteViewControllerProtocol) {
        self.view = view
        self.controller = controller
    }
}
