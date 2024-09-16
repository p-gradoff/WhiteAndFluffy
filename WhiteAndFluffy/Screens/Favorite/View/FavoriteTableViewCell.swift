//
//  FavoriteTableViewCell.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 16.09.2024.
//

import UIKit

// MARK: - cell that contains photo miniature and author's nickname
final class FavoriteTableViewCell: UITableViewCell {
    static let reuseID: String = UUID().uuidString
    
    private let photoView: UIImageView = {
        .config(view: $0) {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
        }
    }(UIImageView())
    
    private let usernameLabel: UILabel = AppUICreator.createLabel(with: .getCormorantGaramondFont(size: 32))
    
    func setupCell(with photo: UIImage, text: String) {
        photoView.image = photo
        usernameLabel.text = text
        
        addSubviews(photoView, usernameLabel)
        activateConstraints()
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            photoView.widthAnchor.constraint(equalToConstant: 100),
            photoView.heightAnchor.constraint(equalToConstant: 100),
            
            usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 40),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
