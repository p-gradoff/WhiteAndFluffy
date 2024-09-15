//
//  Builder.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

final class Builder {
    // MARK: мб поменять название на конфигурацию всего проекта
    static func buildTabBar() -> UITabBarController {
        let feedViewController = buildFeedViewController()
        feedViewController.tabBarItem = UITabBarItem(title: "Gallery", image: UIImage(systemName: "photo.fill"), tag: 0)
        
        let favoriteViewController = buildFavoriteViewController()
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "bookmark.fill"), tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [feedViewController, favoriteViewController]
        return tabBarController
        
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
