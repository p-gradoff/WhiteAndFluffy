//
//  UnsplashViewController.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UnsplashPhotoPicker
import UIKit

protocol UnsplashViewControllerProtocol: AnyObject {
    func pushViewController(_ targetController: UIViewController)
}

final class UnsplashViewController: UIViewController {
    private let presenter: UnsplashPresenterProtocol
    
    private let config = UnsplashPhotoPickerConfiguration(
        accessKey: Token.accessKey.rawValue,
        secretKey: Token.secretKey.rawValue
    )
    
    private lazy var photoPicker: UnsplashPhotoPicker = {
        $0.photoPickerDelegate = self
        $0.modalPresentationStyle = .overFullScreen
        return $0
    }(UnsplashPhotoPicker(configuration: config))
    
    struct Dependencies {
        let presenter: UnsplashPresenterProtocol
    }
    
    init(dependencies: Dependencies) {
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
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        present(photoPicker, animated: true)
    }
    
}

extension UnsplashViewController: UnsplashPhotoPickerDelegate {
    func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
        print(photos.first!.identifier)
        presenter.setupInformationScreen(with: photos.first!)
    }
    
    func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {
        //
    }
}

extension UnsplashViewController: UnsplashViewControllerProtocol {
    func pushViewController(_ targetController: UIViewController) {
        navigationController?.pushViewController(targetController, animated: false)
    }
}



