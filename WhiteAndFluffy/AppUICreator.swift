//
//  AppUICreator.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 16.09.2024.
//

import UIKit

// MARK: - class that helps views to form UI elements by the template
final class AppUICreator {
    static func createLabel(with font: UIFont, text: String = "", alignment: NSTextAlignment = .left) -> UILabel {
        .config(view: UILabel()) {
            $0.font = font
            $0.text = text
            $0.textAlignment = alignment
        }
    }
}
