//
//  ProfileDateView.swift
//  SMovie
//
//  Created by Вова on 07.04.2023.
//

import UIKit

class ProfileDateInputView: UIView {
    
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
    
    let calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "calendarIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var datePicker: UIDatePicker!
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setDatePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(label)
        addSubview(textField)
        addSubview(calendarImageView)
        setConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Set Date Picker
    
    func setDatePicker () {
        datePicker = UIDatePicker.init(frame: CGRect(
            x: 0,
            y: 0,
            width: self.bounds.width,
            height: 200))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self,
                             action: #selector(self.dateChanged),
                             for: .allEvents)
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        self.textField.inputView = datePicker
        let toolBar: UIToolbar = UIToolbar.init(frame: CGRect(
            x: 0,
            y: 0,
            width: self.bounds.width,
            height: 50))
        let spaceButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton:  UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapOnDoneButton))
        toolBar.setItems([spaceButton,doneButton], animated: true)
        self.textField.inputAccessoryView = toolBar
    }
    
    @objc func dateChanged () {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        self.textField.text = dateFormat.string(from: datePicker.date)
    }
    
    @objc func tapOnDoneButton () {
        textField.resignFirstResponder()
    }
}

//MARK: - Set Constraints


extension ProfileDateInputView {
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
        
        NSLayoutConstraint.activate([
            calendarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            calendarImageView.centerYAnchor.constraint (equalTo: textField.centerYAnchor, constant: 0),
            calendarImageView.heightAnchor.constraint  (equalToConstant: 20),
            calendarImageView.widthAnchor.constraint   (equalToConstant: 20)
        ])
    }
}

