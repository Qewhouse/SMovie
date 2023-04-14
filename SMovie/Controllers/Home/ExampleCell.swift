//
//  ExampleCell.swift
//  SMovie
//
//  Created by Вова on 11.04.2023.
//

import UIKit

class ExampleCell: UICollectionViewCell {
    
    static let identifier = "ExampleCell"
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Movieposter")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Drifting Home"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Theme.reversedAppColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Action"
        label.textColor = Theme.lightGrayText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let alarmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clock")
        imageView.tintColor = Theme.grayColor
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "148 minutes"
        label.textColor = Theme.lightGrayText
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Favorite")?.withRenderingMode(.alwaysOriginal)
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "star")
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "4.4"
        label.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = UIColor(named: "appColor")
        
        addSubview(posterImageView)
        addSubview(categoryLabel)
        addSubview(nameLabel)
        addSubview(alarmImageView)
        addSubview(timeLabel)
        addSubview(heartImageView)
        addSubview(rankLabel)
        addSubview(starImageView)

    }
    
    func configureCell (image: UIImage, category: String, name: String, time: Int, rank: Double) {
        posterImageView.image = image
        categoryLabel.text = category
        nameLabel.text = name
        timeLabel.text = String(time) + " Minutes"
        rankLabel.text = String(format: "%.1f", rank)
        
    }
    
    func setConstraints () {
        let screenHeight = UIScreen.main.bounds.height
        
        NSLayoutConstraint.activate([
            posterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            posterImageView.heightAnchor.constraint(equalToConstant: screenHeight/9),
            posterImageView.widthAnchor.constraint(equalToConstant: screenHeight/9),
        ])
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            alarmImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            alarmImageView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: alarmImageView.trailingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            heartImageView.topAnchor.constraint(equalTo: topAnchor),
            heartImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heartImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            rankLabel.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 0),
            rankLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            starImageView.bottomAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 0),
            starImageView.trailingAnchor.constraint(equalTo: rankLabel.leadingAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
