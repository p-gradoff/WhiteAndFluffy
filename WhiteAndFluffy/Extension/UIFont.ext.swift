//
//  UIFont.ext.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 16.09.2024.
//

import UIKit

enum CormorantGaramond: String {
    case regular = "CormorantGaramond-Regular"
    case bold = "CormorantGaramond-Bold"
}

extension UIFont {
    static func getCormorantGaramondFont(type: CormorantGaramond = .regular, size: CGFloat) -> UIFont {
        return UIFont.init(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: 1)
    }
}
