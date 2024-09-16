//
//  FavoriteView.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import UIKit

protocol FavoriteViewProtocol: UIView {
    func updateCellData(with data: [PhotoInfoModel])
    func setupFavoritePresenter(_ presenter: FavoritePresenterDelegate)
}

final class FavoriteView: UIView {
    private weak var favoritePresenter: FavoritePresenterDelegate?

    private var cellData: [PhotoInfoModel] = []
    
    private lazy var tableView: UITableView = {
        $0.bouncesVertically = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseID)
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
    func setupFavoritePresenter(_ presenter: FavoritePresenterDelegate) {
        self.favoritePresenter = presenter
    }
    
    func updateCellData(with data: [PhotoInfoModel]) {
        cellData = data
        tableView.reloadData()
    }
}

extension FavoriteView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseID, for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
        
        cell.setupCell(
            with: cellData[indexPath.row].photo!,
            text: cellData[indexPath.row].username!
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { "Your collection:" }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 30 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoritePresenter?.transmitInformation(cellData[indexPath.row])
    }
}

extension FavoriteView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 120 }
    
}

extension String {
    static let cellIdentified = "\(UITableViewCell.self)"
}
