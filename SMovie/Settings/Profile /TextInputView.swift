//
//  ProfileInputView.swift
//  SMovie
//
//  Created by Вова on 06.04.2023.
//

import UIKit

class TextInputView: UIView {
    
    //MARK: - Properties
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.5411760807, green: 0.5411768556, blue: 0.5583735108, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor(named: "violetColor")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 30
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
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
        backgroundColor = .white
        addSubview(label)
        addSubview(textField)
    }
}

//MARK: - Set Constraints

extension TextInputView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint (equalTo: leadingAnchor,  constant: 0),
            label.topAnchor.constraint     (equalTo: topAnchor,      constant: 0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint (equalTo: leadingAnchor,     constant: 0),
            textField.topAnchor.constraint     (equalTo: label.bottomAnchor,constant: 15),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            textField.heightAnchor.constraint  (equalToConstant: 60)
        ])
    }
}
