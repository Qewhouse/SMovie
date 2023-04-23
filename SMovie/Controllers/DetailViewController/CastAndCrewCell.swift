//
//  CastAndCrewCell.swift
//  SMovie
//
//  Created by Eduard Tokarev on 09.04.2023.
//

import UIKit

final class CastAndCrewCell: UICollectionViewCell {
    private let stackViewHorizontal: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let stackViewVertical: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let imageCell: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imageView.layer.cornerRadius = imageView.frame.height / 2.2
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let vocabularyLabel: UILabel = {
        let label = UILabel()
         label.font = .systemFont(ofSize: 14)
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
    
    func setupCell(withImage image: UIImage?, name: String?, vocabulary: String) {
        imageCell.image = image
        nameLabel.text = name
        vocabularyLabel.text = vocabulary
        
    }
    
    private func addSubviews() {
        [stackViewHorizontal].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(item)
        }
        
        [imageCell, stackViewVertical].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            stackViewHorizontal.addArrangedSubview(item)
        }
        
        [nameLabel, vocabularyLabel].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            stackViewVertical.addArrangedSubview(item)
        }
    }
    
    private func addViewConstraints() {
        NSLayoutConstraint.activate([
            stackViewHorizontal.topAnchor.constraint(equalTo: topAnchor,constant: 5),
            stackViewHorizontal.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            stackViewHorizontal.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewHorizontal.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageCell.heightAnchor.constraint(equalToConstant: 50),
            imageCell.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
