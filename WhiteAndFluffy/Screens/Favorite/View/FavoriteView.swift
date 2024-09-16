//
//  FavoriteView.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

protocol FavoriteViewProtocol: UIView {
    func updateCellData(with data: [FavoriteInfoModel])
    func setupFavoritePresenter(_ presenter: FavoritePresenterProtocol)
}

final class FavoriteView: UIView {
    private weak var favoritePresenter: FavoritePresenterProtocol?

    private var cellData: [FavoriteInfoModel] = []
    
    private lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.delegate = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: .cellIdentified)
        return $0
    }(UITableView(frame: frame, style: .plain))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(tableView)
    }
}

extension FavoriteView: FavoriteViewProtocol {
    func setupFavoritePresenter(_ presenter: FavoritePresenterProtocol) {
        self.favoritePresenter = presenter
    }
    
    func updateCellData(with data: [FavoriteInfoModel]) {
        cellData = data
        tableView.reloadData()
    }
}

extension FavoriteView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .cellIdentified, for: indexPath)
        
        guard !cellData.isEmpty else { return UITableViewCell() }
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = cellData[indexPath.row].username
        cellConfig.textProperties.font = .getCormorantGaramondFont(size: 32)
        cellConfig.textProperties.alignment = .center
        cellConfig.imageToTextPadding = 20
        cellConfig.image = cellData[indexPath.row].photo
        cellConfig.imageProperties.cornerRadius = 5
        cellConfig.imageProperties.maximumSize = CGSize(width: cell.frame.height, height: cell.frame.height)
        
        cell.contentConfiguration = cellConfig
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Your collection"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}

extension FavoriteView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 80 }
}

extension String {
    static let cellIdentified = "\(UITableViewCell.self)"
}
