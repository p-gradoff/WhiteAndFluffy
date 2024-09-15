//
//  FeedViewController.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

protocol FeedViewControllerProtocol: AnyObject {
    
}

final class FeedViewController: UIViewController {
    private let feedView: FeedViewProtocol
    private let presenter: FeedPresenterProtocol
    
    struct Dependencies {
        let presenter: FeedPresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.feedView = FeedView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(feedView)
    }

    override func loadView() {
        super.loadView()
        presenter.loadPresenter(with: feedView, controller: self)
    }
}

extension FeedViewController: FeedViewControllerProtocol {
    
}
