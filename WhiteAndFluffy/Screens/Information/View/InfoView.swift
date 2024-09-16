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
    func setupInformation(username: String, creationDate: String, location: String, downloadsCount: String)
}

final class InfoView: UIView {
    internal var imageView: UIImageView = {
        .config(view: $0) {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 15
        }
    }(UIImageView())
    
    private var usernameLabel: UILabel = AppUICreator.createLabel(
        with: .getCormorantGaramondFont(type: .bold, size: 32),
        alignment: .center
    )
    
    private lazy var canvasView: UIView = {
        .config(view: $0) {
            $0.backgroundColor = .appLightGray
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
        }
    }(UIView())

    private var creationDateLabel: UILabel = AppUICreator.createLabel(
        with: .systemFont(ofSize: 18, weight: .thin),
        text: "\(String.middlePoint) Creation date: "
    )
    
    private var locationLabel: UILabel = AppUICreator.createLabel(
        with: .systemFont(ofSize: 18, weight: .thin),
        text: "\(String.middlePoint) Location: "
    )
    
    private var downloadsLabel: UILabel = AppUICreator.createLabel(
        with: .systemFont(ofSize: 18, weight: .thin),
        text: "\(String.middlePoint) Downloads count: "
    )
    
    private lazy var infoStackView: UIStackView = {
        .config(view: UIStackView()) { [weak self] stack in
            stack.axis = .vertical
            //stack.spacing = 10
            stack.alignment = .leading
            stack.distribution = .fillEqually
            
            guard let self = self else { return }
            [creationDateLabel, locationLabel, downloadsLabel].forEach { label in
                stack.addArrangedSubview(label)
            }
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        canvasView.addSubview(infoStackView)
        addSubviews(imageView, usernameLabel, canvasView)
    }
}

extension InfoView: InfoViewProtocol {
    func activateConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -320),
            
            usernameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            usernameLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 36),
            
            canvasView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 18),
            canvasView.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvasView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            canvasView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            infoStackView.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor, constant: 10),
            infoStackView.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor, constant: -10),
            infoStackView.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor, constant: -10)
        ])
    }
    
    func setupInformation(username: String, creationDate: String, location: String, downloadsCount: String) {
        usernameLabel.text = username
        creationDateLabel.text?.append(creationDate)
        locationLabel.text?.append(location)
        downloadsLabel.text?.append(downloadsCount)
    }
}

