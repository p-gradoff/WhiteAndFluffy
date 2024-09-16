//
//  FavouriteViewController.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

protocol FavoriteViewControllerProtocol: AnyObject {
    
}

final class FavoriteViewController: UIViewController {
    private let favouriteView: FavoriteViewProtocol
    private let presenter: FavoritePresenterDelegate
    
    struct Dependencies {
        let presenter: FavoritePresenterDelegate
    }
    
    init(dependencies: Dependencies) {
        self.favouriteView = dependencies.presenter.view
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        presenter.loadPresenter(controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(favouriteView)
    }
}

extension FavoriteViewController: FavoriteViewControllerProtocol {
    
}
