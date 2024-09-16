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
        let unsplashViewController = buildUnsplashViewController()
        unsplashViewController.tabBarItem = UITabBarItem(title: "Unsplash", image: UIImage(systemName: "photo.fill"), tag: 0)
        
        let favoriteViewController = buildFavoriteViewController()
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "bookmark.fill"), tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [unsplashViewController, favoriteViewController]
        return tabBarController
        
        func buildFavoriteViewController() -> UINavigationController {
            let model = FavoriteModel()
            let presenter = FavoritePresenter(dependencies: .init(model: model))
            let favoriteVC = FavoriteViewController(dependencies: .init(presenter: presenter))
            let controller = UINavigationController(rootViewController: favoriteVC)
            
            return controller
        }
        
        func buildUnsplashViewController() -> UINavigationController {
            let presenter = UnsplashPresenter()
            let unsplashVC = UnsplashViewController(dependencies: .init(presenter: presenter))
            let controller = UINavigationController(rootViewController: unsplashVC)
            
            return controller
        }
    }
    
    static func buildInformationViewController(photo: UnsplashPhoto) -> UIViewController {
        let model = PhotoInfoModel(photo: photo)
        let presenter = InfoPresenter(model: model)
        let controller = InfoViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
