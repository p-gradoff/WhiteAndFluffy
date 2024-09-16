//
//  FavoriteModel.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

protocol FavoriteModelProtocol: AnyObject {
    var getPhotosData: [FavoriteInfoModel] { get }
    func addPhoto(by model: FavoriteInfoModel)
    func removePhoto(by id: String)
}

final class FavoriteModel {
    private var favorites: [String: FavoriteInfoModel] = [:]
}

struct FavoriteInfoModel {
    let id: String
    let photo: UIImage
    let photoURL: URL?
    let username: String
}

extension FavoriteModel: FavoriteModelProtocol {
    var getPhotosData: [FavoriteInfoModel] {
        get { Array(favorites.values) }
    }
    
    func addPhoto(by model: FavoriteInfoModel) {
        favorites[model.id] = model
    }
    
    func removePhoto(by id: String) {
        favorites[id] = nil
    }
}

