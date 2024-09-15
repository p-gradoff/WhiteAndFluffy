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
    private let presenter: FavoritePresenterProtocol
    
    struct Dependencies {
        let presenter: FavoritePresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.favouriteView = FavoriteView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
    }
    
    override func loadView() {
        super.loadView()
        presenter.loadPresenter(with: favouriteView, controller: self)
    }

}

extension FavoriteViewController: FavoriteViewControllerProtocol {
    
}
