//
//  UIFont.ext.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 16.09.2024.
//

import UIKit

// MARK: - contatins custom font naming
enum CormorantGaramond: String {
    case regular = "CormorantGaramond-Regular"
    case bold = "CormorantGaramond-Bold"
}

extension UIFont {
    // MARK: - static method that return specified custom font
    static func getCormorantGaramondFont(type: CormorantGaramond = .regular, size: CGFloat) -> UIFont {
        return UIFont.init(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: 1)
    }
}
