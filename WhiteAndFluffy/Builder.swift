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
        let unsplashViewController = UINavigationController(rootViewController: UnsplashViewController())
        unsplashViewController.tabBarItem = UITabBarItem(title: "Unsplash", image: UIImage(systemName: "photo.fill"), tag: 0)
        
        let favoriteViewController = buildFavoriteViewController()
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "bookmark.fill"), tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [unsplashViewController, favoriteViewController]
        return tabBarController
        
        // MARK: возможно удалить за ненадобностью
        func buildFeedViewController() -> UINavigationController {
            let model = FeedModel()
            let presenter = FeedPresenter(dependencies: .init(model: model))
            let feedVC = FeedViewController(dependencies: .init(presenter: presenter))
            let controller = UINavigationController(rootViewController: feedVC)
            
            return controller
        }
        
        func buildFavoriteViewController() -> UINavigationController {
            let model = FavoriteModel()
            let presenter = FavoritePresenter(dependencies: .init(model: model))
            let favoriteVC = FavoriteViewController(dependencies: .init(presenter: presenter))
            let controller = UINavigationController(rootViewController: favoriteVC)
            
            return controller
        }
        
        func buildUnsplashPhotoPicker() -> UINavigationController {
            class MyClass {
                
            }
            // MARK: защита ключей
            let config = UnsplashPhotoPickerConfiguration(
                accessKey: "baCvunmA2XzfsRavdVIzhghHURCbr4V073wovijPK-I",
                secretKey: "NJToujRMGpku0kZEoEVnSY5LHBHvljwcN9ykix_0Yv0"
            )
            let photoPicker: UnsplashPhotoPicker = UnsplashPhotoPicker(configuration: config)
            
            return photoPicker
        }
    }
    
/*
    static func buildFeedViewController() -> UINavigationController {
        let model = FeedModel()
        let presenter = FeedPresenter(dependencies: .init(model: model))
        let feedVC = FeedViewController(dependencies: .init(presenter: presenter))
        let controller = UINavigationController(rootViewController: feedVC)
        
        return controller
    }
    
    static func buildFavoriteViewController() -> UINavigationController {
        let model = FavoriteModel()
        let presenter = FavoritePresenter(dependencies: .init(model: model))
        let favoriteVC = FavoriteViewController(dependencies: .init(presenter: presenter))
        let controller = UINavigationController(rootViewController: favoriteVC)
        
        return controller
    }
*/
    
}
