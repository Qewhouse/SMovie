//
//  SettingSwitchCell.swift
//  SMovie
//
//  Created by Вова on 04.04.2023.
//

import UIKit

class SettingSwitchCell: UITableViewCell {
    
    static let reuseIdentifier = "SettingSwitchCell"
    
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
    
    let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = UIColor(named: "violetColor")
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(settingLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(switcher)
        contentView.clipsToBounds = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        switcher.sizeToFit()
        switcher.frame = CGRect(
            x: contentView.frame.size.width - switcher.frame.size.width - 20,
            y: 15,
            width: switcher.frame.size.width,
            height: switcher.frame.size.height)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure (with model: SettingsSwitchModel) {
        settingLabel.text = model.title
        iconImageView.image = model.icon
        switcher.isOn = model.isOn
    }
}


