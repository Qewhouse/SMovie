//
//  HeaderSeeAllView.swift
//  SMovie
//
//  Created by Вова on 20.04.2023.
//

import UIKit

class HeaderSeeAllView: UICollectionReusableView {
    
    static var identifier = "headerSeeAll"
    
    private let headerLabel: UILabel = {
        let view = UILabel()
        view.text = "Box Office"
        view.textColor = Theme.reversedAppColor
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.setTitleColor(Theme.reversedAppColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
        addSubview(seeAllButton)
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
            
            seeAllButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
        ])
    }
}


