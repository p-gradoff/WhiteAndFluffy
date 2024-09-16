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
    func isPhotoInFavorites(by id: String) -> Bool
}

// MARK: - class that presents favorite photos collection and allows to edit it
final class FavoriteModel {
    private var favorites: [String: PhotoInfoModel] = [:]
}

extension FavoriteModel: FavoriteModelProtocol {
    // MARK: - get all collection photos
    var getPhotosData: [PhotoInfoModel] {
        get { Array(favorites.values) }
    }
    
    // MARK: - add new photo in collection
    func addPhoto(by model: PhotoInfoModel) {
        favorites[model.id] = model
    }
    
    // MARK: - remove photo from colllection
    func removePhoto(by id: String) {
        favorites[id] = nil
    }
    
    // MARK: - check for photo in the collection
    func isPhotoInFavorites(by id: String) -> Bool {
        favorites.keys.contains(id)
    }
}

