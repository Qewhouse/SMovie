//
//  ProfileImagePickerView.swift
//  SMovie
//
//  Created by Вова on 06.04.2023.
//

import UIKit

protocol ChangePhotoProtocol { //этот протокол чтобы ChangePhotoVC делегировал смену фото ProfileImageView
    
    func takePhotoPressed()
    
    func changeFromFilePressed ()
    
    func deletePressed()
}

class ProfileImageView: UIView, ChangePhotoProtocol {
    
    //MARK: - Properties
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage (named: "profileImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let pickerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "editPhotoButton"), for: .normal)
        button.addTarget(self, action: #selector(pickerButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Picker Function
    
    @objc func pickerButtonPressed() {
        
        let changePictureVC = ChangePictureViewController()
        changePictureVC.delegate = self
        changePictureVC.modalPresentationStyle = .overCurrentContext
        changePictureVC.modalTransitionStyle = .crossDissolve
        self.window?.rootViewController?.present(changePictureVC, animated: true)
        
    }
    
    //MARK: - ChangePhotoProtocol Fuctions
    
    func takePhotoPressed() {
        let pickerVC = UIImagePickerController()
        pickerVC.sourceType = .camera
        pickerVC.delegate = self
        pickerVC.allowsEditing = true
        self.window?.rootViewController?.present(pickerVC, animated: true)
    }
    
    func changeFromFilePressed() {
        let pickerVC = UIImagePickerController()
        pickerVC.sourceType = .photoLibrary
        pickerVC.delegate = self
        pickerVC.allowsEditing = true
        self.window?.rootViewController?.present(pickerVC, animated: true)
        
    }
    
    func deletePressed() {
        profileImageView.image = #imageLiteral(resourceName: "defaultImage")
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
    }
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(profileImageView)
        addSubview(pickerButton)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - Image Picker Delegates

extension ProfileImageView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let libraryImage =  info[.editedImage] as? UIImage
        
        if let newImage = libraryImage  {
            profileImageView.image = newImage
            profileImageView.layer.masksToBounds = true
            profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

//MARK: - Set Constraints

extension ProfileImageView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint  (equalToConstant: CGFloat(120)),
            profileImageView.heightAnchor.constraint (equalToConstant: CGFloat(120)),
        ])
        
        NSLayoutConstraint.activate([
            pickerButton.rightAnchor.constraint (equalTo: profileImageView.rightAnchor, constant: 0),
            pickerButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant: 0),
            pickerButton.widthAnchor.constraint (equalToConstant: CGFloat(40)),
            pickerButton.heightAnchor.constraint(equalToConstant: CGFloat(40))
        ])
    }
}

