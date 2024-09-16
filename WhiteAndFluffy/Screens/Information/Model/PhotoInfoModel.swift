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
    
    init(photoID: String, photoURL: URL?) {
        self.photoID = photoID
        self.photoURL = photoURL
    }
}
