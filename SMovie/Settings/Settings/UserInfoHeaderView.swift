//
//  UserInfoHeader.swift
//  SMovie
//
//  Created by Вова on 04.04.2023.
//

import UIKit

class UserInfoHeaderView : UIView {
    
    //MARK: - Properties
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage (named: "profileImage")
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Andy Lexsian"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userMailLabel: UILabel = {
        let label = UILabel()
        label.text = "andylexsian@ios.com"
        label.textColor = #colorLiteral(red: 0.4746692777, green: 0.514767766, blue: 0.5520746112, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .white
        addSubview(profileImageView)
        addSubview(userNameLabel)
        addSubview(userMailLabel)
        translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
        
    }
    //MARK: - Constraints

    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: CGFloat(60)),
            profileImageView.heightAnchor.constraint(equalToConstant: CGFloat(60)),
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10),
            userNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12),
        ])
        
        NSLayoutConstraint.activate([
            userMailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10),
            userMailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
        ])
    }
}
