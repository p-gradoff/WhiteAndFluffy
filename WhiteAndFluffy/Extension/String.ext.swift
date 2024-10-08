//
//  String.ext.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 16.09.2024.
//

import Foundation

extension String {
    // MARK: - middlePoint character
    static let middlePoint = "\u{2022}"
    
    // MARK: - method that removes extra characters
    func getDate() -> String {
        let endIndex = self.index(self.startIndex, offsetBy: 9)
        let sliceString = self[...endIndex]
        return String(sliceString)
    }
}
