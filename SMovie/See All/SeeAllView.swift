//
//  SeeAllView.swift
//  SMovie
//
//  Created by Вова on 20.04.2023.
//
import UIKit

final class SeeAllView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 180
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = Theme.appColor
        tableView.register(PlayTableViewCell.self,
                           forCellReuseIdentifier: PlayTableViewCell.identifier)
        addConstraints()
    }
    
    private func addConstraints() {
        addSubviews (tableView)
        
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 1),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

