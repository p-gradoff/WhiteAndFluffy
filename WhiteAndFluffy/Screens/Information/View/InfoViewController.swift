//
//  InfoViewController.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

final class InfoViewController: UIViewController, UIViewControllerProtocol {
    private weak var presenter: InfoPresenterProtocol?
    private let infoView: InfoViewProtocol
    internal var id: String = UUID().uuidString

    struct Dependencies {
        let presenter: InfoPresenterProtocol
    }
    
    init(dependencies: Dependencies) {
        self.infoView = InfoView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        print("initialize infoVC \(id)")
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("deinit \(id)")
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
    }
}
