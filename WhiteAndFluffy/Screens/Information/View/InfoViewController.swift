//
//  InfoViewController.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

// MARK: - controller that presents photo and it's information
final class InfoViewController: UIViewController, UIViewControllerProtocol {
    // MARK: - private properties
    private weak var presenter: InfoPresenterProtocol?
    private let infoView: InfoViewProtocol

    // MARK: - initialization
    struct Dependencies {
        let presenter: InfoPresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.infoView = InfoView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        presenter?.loadPresenter(with: infoView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(infoView)
        navigationController?.isNavigationBarHidden = true
    }
}
