//
//  InfoModel.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UnsplashPhotoPicker

struct PhotoInfoModel {
    let photoID: String
    let fullPhotoURL: URL?
    let smallPhotoURL: URL?
    
    init(photo: UnsplashPhoto) {
        self.photoID = photo.identifier
        self.fullPhotoURL = photo.urls[.full]
        self.smallPhotoURL = photo.urls[.small]
    }
}
