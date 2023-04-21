//
//  MainDetailsTableViewCell.swift
//  SMovie
//
//  Created by Alexander Altman on 09.04.2023.
//

import UIKit

final class MainDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "MainDetailsTableViewCell"
    private let customTableViewCell = CustomTableViewCell()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(customTableViewCell)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            customTableViewCell.topAnchor.constraint(equalTo: topAnchor),
            customTableViewCell.leadingAnchor.constraint(equalTo: leadingAnchor),
            customTableViewCell.trailingAnchor.constraint(equalTo: trailingAnchor),
            customTableViewCell.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    public func configure(with imageName: String, name: String, time: String) {
        customTableViewCell.customImageView.image = UIImage(named: imageName)
        customTableViewCell.nameLabel.text = name
        customTableViewCell.rankLabel.text = time
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
