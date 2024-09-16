//
//  Builder.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit
import UnsplashPhotoPicker

final class Builder {
    // MARK: - builds all dependencies of controllers
    static func buildTabBar() -> UITabBarController {
        let favoritePresenter = buildFavoritePresenter()
        let infoPresenter = buildInformationScreen(favoritePresenter: favoritePresenter)
        
        let unsplashViewController = buildUnsplashViewController(using: infoPresenter)
        unsplashViewController.tabBarItem = UITabBarItem(title: "Unsplash", image: UIImage(systemName: "photo.fill"), tag: 0)
        
        let favoriteViewController = buildFavoriteViewController(using: favoritePresenter)
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "bookmark.fill"), tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [unsplashViewController, favoriteViewController]
        return tabBarController
        
        // MARK: - builds FavoritePresenter separated because other presenters need its to setup correct navigation
        func buildFavoritePresenter() -> FavoritePresenterProtocol {
            let model = FavoriteModel()
            let view = FavoriteView(frame: UIScreen.main.bounds)
            let presenter = FavoritePresenter(dependencies: .init(model: model, view: view))
            return presenter
        }
        
        // MARK: - builds favorite photos screen controller
        func buildFavoriteViewController(using presenter: FavoritePresenterProtocol) -> UINavigationController {
            let favoriteVC = FavoriteViewController(
                dependencies: .init(presenter: presenter as! FavoritePresenterDelegate))
            let controller = UINavigationController(rootViewController: favoriteVC)
            
            return controller
        }
        
        // MARK: - builds photo's information screen
        func buildInformationScreen(favoritePresenter: FavoritePresenterProtocol) -> InfoPresenterProtocol {
            let presenter = InfoPresenter(favoritePresenter: favoritePresenter)
            presenter.controller = InfoViewController(dependencies: .init(presenter: presenter))
            return presenter
        }
        
        // MARK: - builds unsplash photo collection controller
        func buildUnsplashViewController(using presenter: InfoPresenterProtocol) -> UINavigationController {
            let presenter = UnsplashPresenter(presenter)
            let unsplashVC = UnsplashViewController(dependencies: .init(presenter: presenter))
            let controller = UINavigationController(rootViewController: unsplashVC)
            
            return controller
        }
    }
}
