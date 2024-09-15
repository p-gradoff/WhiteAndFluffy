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
    private let model: InfoModel
    private weak var view: InfoViewProtocol?
    private weak var controller: InfoViewControllerProtocol?
    
    init(model: InfoModel) {
        self.model = model
    }
}

extension InfoPresenter: InfoPresenterProtocol {
    func loadPresenter(with view: InfoViewProtocol, controller: InfoViewControllerProtocol) {
        self.view = view
        self.controller = controller
    }
}
