//
//  InfoViewController.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

protocol InfoViewControllerProtocol: AnyObject {
    
}

final class InfoViewController: UIViewController {
    private let presenter: InfoPresenterProtocol
    private let infoView: InfoViewProtocol

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
        presenter.loadPresenter(with: infoView, controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(infoView)
    }
}

extension InfoViewController: InfoViewControllerProtocol {
    
}
