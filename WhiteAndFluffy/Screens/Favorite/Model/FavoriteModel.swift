//
//  FavoriteModel.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

protocol FavoriteModelProtocol: AnyObject {
    var getPhotosData: [PhotoInfoModel] { get }
    func addPhoto(by model: PhotoInfoModel)
    func removePhoto(by id: String)
}

final class FavoriteModel {
    private var favorites: [String: PhotoInfoModel] = [:]
}

extension FavoriteModel: FavoriteModelProtocol {
    var getPhotosData: [PhotoInfoModel] {
        get { Array(favorites.values) }
    }
    
    func addPhoto(by model: PhotoInfoModel) {
        favorites[model.id] = model
    }
    
    func removePhoto(by id: String) {
        favorites[id] = nil
    }
}

