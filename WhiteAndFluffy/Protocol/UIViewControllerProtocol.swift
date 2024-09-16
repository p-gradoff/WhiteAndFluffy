//
//  UIViewControllerProtocol.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 16.09.2024.
//

import UIKit

protocol UIViewControllerProtocol: UIViewController {
    func pushViewController(_ targetController: UIViewController)
}

extension UIViewController {
    func pushViewController(_ targetController: UIViewController) {
        navigationController?.pushViewController(targetController, animated: false)
    }
    
    func createAlert(title: String, text: String) {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }
            navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

enum ErrorHeader: String {
    case photoError = "Loading photo error"
    case dataError = "Loading data error"
}
