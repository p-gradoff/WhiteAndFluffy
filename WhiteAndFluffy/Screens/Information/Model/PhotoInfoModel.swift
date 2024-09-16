//
//  InfoModel.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UnsplashPhotoPicker

struct PhotoInfoModel {
    let photoID: String
    let photoURL: URL?
    
    init(photo: UnsplashPhoto) {
        self.photoID = photo.identifier
        self.photoURL = photo.urls[.regular]
    }
}
