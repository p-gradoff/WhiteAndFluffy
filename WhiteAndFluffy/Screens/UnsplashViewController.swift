//
//  UnsplashViewController.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UnsplashPhotoPicker
import UIKit

final class UnsplashViewController: UIViewController {
    private let config = UnsplashPhotoPickerConfiguration(
        accessKey: "baCvunmA2XzfsRavdVIzhghHURCbr4V073wovijPK-I",
        secretKey: "NJToujRMGpku0kZEoEVnSY5LHBHvljwcN9ykix_0Yv0"
    )
    
    private lazy var photoPicker: UnsplashPhotoPicker = {
        $0.photoPickerDelegate = self
        $0.modalPresentationStyle = .overFullScreen
        return $0
    }(UnsplashPhotoPicker(configuration: config))
    
    override func viewDidAppear(_ animated: Bool) {
        present(photoPicker, animated: true)
    }
    
}

extension UnsplashViewController: UnsplashPhotoPickerDelegate {
    func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
        //
    }
    
    func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {
        //
    }
}





