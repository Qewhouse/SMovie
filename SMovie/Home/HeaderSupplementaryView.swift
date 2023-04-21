//
//  HeaderSupplementaryView.swift
//  SMovie
//
//  Created by Вова on 11.04.2023.
//
import UIKit

class HeaderSupplementaryView: UICollectionReusableView {
    
    static var identifier = "header"
    
    private let headerLabel: UILabel = {
        let view = UILabel()
        view.text = "header"
        view.textColor = Theme.reversedAppColor
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeader(categoryName: String) {
        headerLabel.text = categoryName
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
        
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
        ])
    }
}

