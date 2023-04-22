//
//  ProfileGenderInputView.swift
//  SMovie
//
//  Created by Вова on 06.04.2023.
//

import UIKit

class ProfileGenderInputView: UIView {
    
    //MARK: - Properties
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5411760807, green: 0.5411768556, blue: 0.5583735108, alpha: 1)
        label.text = "Gender"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var maleButton: GenderButton = {
        let button = GenderButton()
        button.setTitle("Male", for: .normal)
        button.addTarget(self, action: #selector(tappedOnMaleButton), for: .touchUpInside)
        return button
    }()
    
    var femaleButton: GenderButton = {
        let button = GenderButton()
        button.setTitle("Female", for: .normal)
        button.addTarget(self, action: #selector(tappedOnFemaleButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedOnMaleButton () {
        
        if maleButton.flag == false {
            
            maleButton.flag = true
            femaleButton.flag = false
            
            maleButton.setImage(UIImage(named: maleButton.flag ? "checked" : "unchecked"), for: .normal)
            femaleButton.setImage(UIImage(named: femaleButton.flag ? "checked" : "unchecked"), for: .normal)
        }
    }
    
    @objc func tappedOnFemaleButton () {
        
        if femaleButton.flag == false {
            
            femaleButton.flag = true
            maleButton.flag = false
            
            maleButton.setImage(UIImage(named: maleButton.flag ? "checked" : "unchecked"), for: .normal)
            femaleButton.setImage(UIImage(named: femaleButton.flag ? "checked" : "unchecked"), for: .normal)
        }
    }
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = Theme.appColor
        addSubview(label)
        addSubview(maleButton)
        addSubview(femaleButton)
    }
}

//MARK: - Set Constraints

extension ProfileGenderInputView {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint (equalTo: leftAnchor,  constant: 0),
            label.topAnchor.constraint  (equalTo: topAnchor,      constant: 0),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            maleButton.leftAnchor.constraint  (equalTo: leftAnchor,     constant: 0),
            maleButton.topAnchor.constraint   (equalTo: label.bottomAnchor,constant: 15),
            maleButton.rightAnchor.constraint (equalTo: centerXAnchor, constant: -10),
            maleButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            femaleButton.leftAnchor.constraint  (equalTo: centerXAnchor,  constant: 10),
            femaleButton.topAnchor.constraint   (equalTo: label.bottomAnchor,constant: 15),
            femaleButton.rightAnchor.constraint (equalTo: rightAnchor, constant: 0),
            femaleButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
