//
//  ChangePictureView.swift
//  SMovie
//
//  Created by Вова on 08.04.2023.
//

import UIKit

class ChangePictureView: UIView {
    
    //MARK: - Properties
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Change your picture"
        label.textColor = Theme.reversedAppColor
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lineImageView: UIImageView = {
        let lineImage = UIImageView()
        lineImage.image = UIImage(named: "lineImage")
        lineImage.contentMode = .scaleToFill
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        return lineImage
    }()
    
    let takePhotoButton: ChangePictureButton = {
        let button = ChangePictureButton()
        button.setTitle("Take a photo", for: .normal)
        button.setImage(UIImage(named: "cameraIcon"), for: .normal)
        button.setTitleColor(Theme.reversedAppColor, for: .normal)
        button.backgroundColor = Theme.appColor
        return button
    }()
    
    let chooseFileButton: ChangePictureButton = {
        let button = ChangePictureButton()
        button.setTitle("Choose from your file", for: .normal)
        button.setImage(UIImage(named: "fileIcon"), for: .normal)
        button.setTitleColor(Theme.reversedAppColor, for: .normal)
        button.backgroundColor = Theme.appColor
        button.imageEdgeInsets.left = -100
        button.titleEdgeInsets.left = -90
        return button
    }()
    
    let deleteButton: ChangePictureButton = {
        let button = ChangePictureButton()
        button.setTitle("Delete photo", for: .normal)
        button.setImage(UIImage(named: "trashIcon"), for: .normal)
        button.backgroundColor = Theme.appColor
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Setup Views

    func setupViews() {
        backgroundColor = Theme.appColor
        addSubview(topLabel)
        addSubview(lineImageView)
        addSubview(takePhotoButton)
        addSubview(chooseFileButton)
        addSubview(deleteButton)
        layer.cornerRadius = 15
    }
}

//MARK: - Set Constraints

extension ChangePictureView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint   (equalTo: topAnchor,  constant:  30),
            topLabel.leftAnchor.constraint  (equalTo: leftAnchor, constant:  10),
            topLabel.rightAnchor.constraint (equalTo: rightAnchor,constant: -10),
            topLabel.bottomAnchor.constraint(equalTo: lineImageView.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            lineImageView.topAnchor.constraint   (equalTo: topLabel.bottomAnchor, constant: 0),
            lineImageView.leftAnchor.constraint  (equalTo: leftAnchor, constant: 0),
            lineImageView.rightAnchor.constraint (equalTo: rightAnchor,constant: 0),
            lineImageView.bottomAnchor.constraint(equalTo: takePhotoButton.topAnchor, constant: -20),
            lineImageView.heightAnchor.constraint(equalToConstant: 2)
            
        ])
        
        NSLayoutConstraint.activate([
            takePhotoButton.topAnchor.constraint   (equalTo: topLabel.bottomAnchor, constant: 0),
            takePhotoButton.leftAnchor.constraint  (equalTo: leftAnchor, constant:  15),
            takePhotoButton.rightAnchor.constraint (equalTo: rightAnchor,constant: -15),
            takePhotoButton.bottomAnchor.constraint(equalTo: chooseFileButton.topAnchor, constant: -20),
            takePhotoButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            chooseFileButton.topAnchor.constraint   (equalTo: takePhotoButton.bottomAnchor, constant: 0),
            chooseFileButton.leftAnchor.constraint  (equalTo: leftAnchor, constant:  15),
            chooseFileButton.rightAnchor.constraint (equalTo: rightAnchor,constant: -15),
            chooseFileButton.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -20),
            chooseFileButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint   (equalTo: chooseFileButton.bottomAnchor, constant: 0),
            deleteButton.leftAnchor.constraint  (equalTo: leftAnchor, constant:  15),
            deleteButton.rightAnchor.constraint (equalTo: rightAnchor,constant: -15),
            deleteButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}



