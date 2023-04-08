//
//  ChangePictureViewController.swift
//  SMovie
//
//  Created by Вова on 08.04.2023.
//

import UIKit

class ChangePictureViewController: UIViewController {
    
    //MARK: - Properties
    
    var delegate: ChangePhotoProtocol?
    
    let contentView: ChangePictureView = {
        let view =  ChangePictureView()
        view.takePhotoButton.addTarget(self, action: #selector(takePhotoPressed), for: .touchUpInside)
        view.chooseFileButton.addTarget(self, action: #selector(chooseFilePressed), for: .touchUpInside)
        view.deleteButton.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        return view
    }()
    
    let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Setup Views
    
    func setupViews() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurView.effect = blurEffect
        view.backgroundColor = .clear
        view.addSubview(blurView)
        view.addSubview(contentView)
        setConstraints()
    }
    //MARK: - Fuction for taps

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    //MARK: - Objc methods for buttons
    
    @objc func takePhotoPressed() {
        self.dismiss(animated: true)
        delegate!.takePhotoPressed()
    }
    
    @objc func chooseFilePressed() {
        self.dismiss(animated: true)
        delegate!.changeFromFilePressed()
    }
    
    @objc func deletePressed() {
        self.dismiss(animated: true)
        delegate!.deletePressed()
    }
}

//MARK: - Set Constraints

extension ChangePictureViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leftAnchor.constraint(equalTo: view.leftAnchor),
            blurView.rightAnchor.constraint(equalTo: view.rightAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
    }
}
