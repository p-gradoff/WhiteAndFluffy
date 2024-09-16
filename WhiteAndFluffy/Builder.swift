//
//  Builder.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit
import UnsplashPhotoPicker

final class Builder {
    // MARK: мб поменять название на конфигурацию всего проекта
    static func buildTabBar() -> UITabBarController {
        let favoritePresenter = buildFavoritePresenter()
        let infoPresenter = buildInformationViewController(favoritePresenter: favoritePresenter)
        
        let unsplashViewController = buildUnsplashViewController(using: infoPresenter)
        unsplashViewController.tabBarItem = UITabBarItem(title: "Unsplash", image: UIImage(systemName: "photo.fill"), tag: 0)
        
        let favoriteViewController = buildFavoriteViewController(using: favoritePresenter)
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "bookmark.fill"), tag: 1)
        
        let tabBarController = UITabBarController()
        // let tabBarController = MyTabBarController()
        tabBarController.viewControllers = [unsplashViewController, favoriteViewController]
        return tabBarController
        
        func buildFavoritePresenter() -> FavoritePresenterProtocol {
            let model = FavoriteModel()
            let view = FavoriteView(frame: UIScreen.main.bounds)
            let presenter = FavoritePresenter(dependencies: .init(model: model, view: view))
            return presenter
        }
        
        func buildFavoriteViewController(using presenter: FavoritePresenterProtocol) -> UINavigationController {
            let favoriteVC = FavoriteViewController(
                dependencies: .init(presenter: presenter as! FavoritePresenterDelegate))
            let controller = UINavigationController(rootViewController: favoriteVC)
            
            return controller
        }
        
        func buildInformationViewController(favoritePresenter: FavoritePresenterProtocol) -> InfoPresenterProtocol {
            let presenter = InfoPresenter(favoritePresenter: favoritePresenter)
            presenter.controller = InfoViewController(dependencies: .init(presenter: presenter))
            return presenter
        }
        
        func buildUnsplashViewController(using presenter: InfoPresenterProtocol) -> UINavigationController {
            let presenter = UnsplashPresenter(presenter)
            let unsplashVC = UnsplashViewController(dependencies: .init(presenter: presenter))
            let controller = UINavigationController(rootViewController: unsplashVC)
            
            return controller
        }
    }
}

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
            print("Выбрана вкладка с индексом: $$index)")
            // Выполните необходимые действия при выборе вкладки
        }
    }
}
