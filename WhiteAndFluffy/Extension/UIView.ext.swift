//
//  UIView.ext.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

extension UIView {
    // MARK: - static method that makes TAMIK false
    static func config<T: UIView>(view: T, completion: @escaping (T) -> Void) -> T {
        view.translatesAutoresizingMaskIntoConstraints = false
        completion(view)
        return view
    }
    
    // MARK: - static method that allows add array of subviews
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
