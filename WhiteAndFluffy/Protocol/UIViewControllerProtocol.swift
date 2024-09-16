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
}
