//
//  CastAndCrewCell.swift
//  SMovie
//
//  Created by Eduard Tokarev on 09.04.2023.
//

import UIKit

final class CastAndCrewCell: UICollectionViewCell {
    private let imageCell: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let vocabularyLabel: UILabel = {
        let label = UILabel()
         label.font = .systemFont(ofSize: 10)
        label.textColor = Theme.grayColor
         return label
     }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubviews()
        addViewConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    func setupCell(withImage image: UIImage, name: String, vocabulary: String) {
        imageCell.image = image
        nameLabel.text = name
        vocabularyLabel.text = vocabulary
        
    }
    
    private func addSubviews() {
        [imageCell, nameLabel, vocabularyLabel].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(item)
        }
    }
    
    private func addViewConstraints() {
        NSLayoutConstraint.activate([
            imageCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCell.heightAnchor.constraint(equalToConstant: 40),
            imageCell.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            vocabularyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            vocabularyLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
    }
}
