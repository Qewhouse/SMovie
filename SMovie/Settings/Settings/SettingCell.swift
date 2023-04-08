//
//  SettingsCell.swift
//  SMovie
//
//  Created by Вова on 04.04.2023.
//

import UIKit

class SettingCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseIdentifier = "SettingsCell"
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let settingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(settingLabel)
        contentView.addSubview(iconImageView)
        contentView.clipsToBounds = true
        self.accessoryType = .disclosureIndicator

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.frame.size.height/3
        iconImageView.frame = CGRect(
            x: 20,
            y: 20,
            width: size,
            height: size)

        settingLabel.frame = CGRect(
            x: 40 + iconImageView.frame.size.width,
            y: 0,
            width: contentView.frame.size.width - iconImageView.frame.size.width - 25,
            height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure (with model: SettingsModel) {
        settingLabel.text = model.title
        iconImageView.image = model.icon
    }
}

