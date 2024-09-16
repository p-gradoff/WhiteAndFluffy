//
//  FavoriteView.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

protocol FavoriteViewProtocol: UIView {
    
}

final class FavoriteView: UIView {
    private lazy var canvasView: UIView = {
        .config(view: $0) {
            $0.backgroundColor = .systemMint
        }
    }(UIView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(canvasView)
        activateConstraints()
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            canvasView.leadingAnchor.constraint(equalTo: leadingAnchor),
            canvasView.topAnchor.constraint(equalTo: topAnchor),
            canvasView.trailingAnchor.constraint(equalTo: trailingAnchor),
            canvasView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension FavoriteView: FavoriteViewProtocol {
    
}
