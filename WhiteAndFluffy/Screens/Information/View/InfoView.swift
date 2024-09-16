//
//  InfoView.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

protocol InfoViewProtocol: UIView {
    var imageView: UIImageView { get set }
    func activateConstraints()
}

final class InfoView: UIView {
    internal var imageView: UIImageView = {
        .config(view: $0) {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 15
        }
    }(UIImageView())
    
    private lazy var canvasView: UIView = {
        .config(view: $0) {
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
        }
    }(UIView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubviews(imageView, canvasView)
        // activateImageViewLayout()
    }
    
    private func activateImageViewLayout() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            canvasView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            canvasView.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvasView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            canvasView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension InfoView: InfoViewProtocol {
    func activateConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: imageView.image!.getRatio()),
            
            // canvasView.topAnchor.constraint(equalTo: topAnchor, constant: 500),
            canvasView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            canvasView.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvasView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            canvasView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
