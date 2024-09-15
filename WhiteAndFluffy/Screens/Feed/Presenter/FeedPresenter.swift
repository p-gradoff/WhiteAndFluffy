//
//  FeedPresenter.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import Foundation

protocol FeedPresenterProtocol: AnyObject {
    func loadPresenter(with view: FeedViewProtocol, controller: FeedViewControllerProtocol)
}

final class FeedPresenter {
    private let model: FeedModelProtocol
    private weak var view: FeedViewProtocol?
    private weak var controllder: FeedViewControllerProtocol?
    
    struct Dependencies {
        let model: FeedModelProtocol
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
    }
}

extension FeedPresenter: FeedPresenterProtocol {
    func loadPresenter(with view: FeedViewProtocol, controller: FeedViewControllerProtocol) {
        self.view = view
        self.controllder = controller
    }
}
