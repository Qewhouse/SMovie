//
//  PosterCell.swift
//  SMovie
//
//  Created by Вова on 10.04.2023.
//

import UIKit

class PosterCell: UICollectionViewCell {
    
    static let identifier = "PosterCell"
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Drifting Home"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var blurView: UIImageView = {
        let view = UIImageView()
        view.alpha = 0.8
        view.image = UIImage(named: "purpleBlur")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Action"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var whiteBlurView: UIView = {
        let view = UIView()
        view.alpha = 0.3
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = UIColor(named: "appColor")
        addSubview(posterImageView)
        addSubview(blurView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(whiteBlurView)
        setConstraints()
    }
    
    func configureCell (image: UIImage, name: String, category: String) {
        posterImageView.image = image
        nameLabel.text = name
        categoryLabel.text = category
    }
    
    func setConstraints () {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint   (equalTo: topAnchor),
            posterImageView.leftAnchor.constraint  (equalTo: leftAnchor),
            posterImageView.rightAnchor.constraint (equalTo: rightAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint   (equalTo: topAnchor),
            blurView.leftAnchor.constraint  (equalTo: leftAnchor),
            blurView.rightAnchor.constraint (equalTo: rightAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor,constant: -5),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            categoryLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -10),
            categoryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            whiteBlurView.bottomAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            whiteBlurView.topAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -5),
            whiteBlurView.leftAnchor.constraint(equalTo: categoryLabel.leftAnchor, constant: -5),
            whiteBlurView.rightAnchor.constraint(equalTo: categoryLabel.rightAnchor, constant: 5),

        ])
        
    }
    
}
