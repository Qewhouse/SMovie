//
//  MainDetailsView.swift
//  SMovie
//
//  Created by Alexander Altman on 09.04.2023.
//

import UIKit

final class MainDetailsView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 180
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = .systemBackground
        tableView.register(MainDetailsTableViewCell.self,
                           forCellReuseIdentifier: MainDetailsTableViewCell.identifier)
        addConstraints()
    }
    
    private func addConstraints() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
