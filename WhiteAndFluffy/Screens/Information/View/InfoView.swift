//
//  InfoView.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

protocol InfoViewProtocol: UIView {
    var imageView: UIImageView { get set }
    var usernameLabel: UILabel { get }
    var likePhoto: ((Bool) -> Void)? { get set }
    var isFavorite: Bool { get set }
    
    func activateConstraints()
    func setupInformation(from model:PhotoInfoModel)
}

// MARK: - view that contains all necessary information for InfoViewController
final class InfoView: UIView {
    // MARK: - internal protocol properties
    internal var imageView: UIImageView = {
        .config(view: $0) {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 15
        }
    }(UIImageView())
    
    internal var usernameLabel: UILabel = AppUICreator.createLabel(
        with: .getCormorantGaramondFont(type: .bold, size: 32)
    )
    
    internal var likePhoto: ((Bool) -> Void)?
    
    internal var isFavorite: Bool = false
    
    // MARK: - private properties
    private lazy var likeButton: UIButton = {
        .config(view: $0) { [weak self] in
            guard let self = self else { return }
            
            $0.setImage(UIImage(systemName: "heart"), for: .normal)
            $0.tintColor = .systemRed
            $0.addTarget(self, action: #selector(onLikeButtonTouch), for: .touchUpInside)
        }
    }(UIButton())
    
    @objc private func onLikeButtonTouch() {
        switch isFavorite {
        case true: isFavorite.toggle()
        case false: isFavorite.toggle()
        }
        
        checkIsFavorite()
        likePhoto?(isFavorite)
    }
    
    private func checkIsFavorite() {
        switch isFavorite {
        case true:
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        case false:
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    private lazy var canvasView: UIView = {
        .config(view: $0) {
            $0.backgroundColor = .appLightGray
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
        }
    }(UIView())

    private var creationDateLabel: UILabel = AppUICreator.createLabel(
        with: .systemFont(ofSize: 18, weight: .thin)
    )
    
    private var locationLabel: UILabel = AppUICreator.createLabel(
        with: .systemFont(ofSize: 18, weight: .thin)
    )
    
    private var downloadsLabel: UILabel = AppUICreator.createLabel(
        with: .systemFont(ofSize: 18, weight: .thin)
    )
    
    private lazy var infoStackView: UIStackView = {
        .config(view: UIStackView()) { [weak self] stack in
            stack.axis = .vertical
            stack.alignment = .leading
            stack.distribution = .fillEqually
            
            guard let self = self else { return }
            [creationDateLabel, locationLabel, downloadsLabel].forEach { label in
                stack.addArrangedSubview(label)
            }
        }
    }()
    
    // MARK: - initialization
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
        addSubviews(imageView, usernameLabel, likeButton, canvasView)
    }
}

extension InfoView: InfoViewProtocol {
    // MARK: - this function is the separated protocol method because of asynchronous data loading. The call will only be made when the download is complete to show the information correctly
    func activateConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -320),
            
            usernameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 18),
            usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            likeButton.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 15),
            likeButton.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor, constant: 3),
            
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
    
    // MARK: - method that allows presenter to setup view's components
    func setupInformation(from model: PhotoInfoModel) {
        usernameLabel.text = model.username
        creationDateLabel.text = "\(String.middlePoint) Creation date: \(model.creationDate ?? DefaultValues.creationDate.rawValue)"
        locationLabel.text =  "\(String.middlePoint) Location: \(model.location ?? DefaultValues.location.rawValue)"
        downloadsLabel.text = "\(String.middlePoint) Downloads count: \(model.downloadsCount ?? DefaultValues.downloadsCount.rawValue)"
        
        isFavorite = model.isLiked
        checkIsFavorite()
    }
}

