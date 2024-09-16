//
//  InfoModel.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UnsplashPhotoPicker

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

enum DefaultValues: String {
    case username = "user"
    case creationDate = "1970-01-01"
    case location = "Moscow"
    case downloadsCount = "0"
}
