//
//  InfoModel.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

// MARK: - photo's information model that contains all the necessary information
struct PhotoInfoModel {
    let id: String
    let photo: UIImage?
    let photoURL: URL?
    let username: String?
    let creationDate: String?
    let location: String?
    let downloadsCount: String?
    var isLiked: Bool
    
    init(id: String, photo: UIImage? = nil, photoURL: URL?, username: String? = nil, creationDate: String? = nil, location: String? = nil, downloadsCount: String? = nil, isLiked: Bool = false) {
        self.id = id
        self.photo = photo
        self.photoURL = photoURL
        self.username = username
        self.creationDate = creationDate
        self.location = location
        self.downloadsCount = downloadsCount
        self.isLiked = isLiked
    }
}

// MARK: - contains default photo's info values 
enum DefaultValues: String {
    case username = "User"
    case creationDate = "1970-01-01"
    case location = "Unknown location"
    case downloadsCount = "0"
}
