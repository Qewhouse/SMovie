//
//  ProfileViewController.swift
//  SMovie
//
//  Created by Вова on 05.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let user = User()
    //MARK: - Properties
    
    private var contentSize : CGSize {
        CGSize(width: view.frame.width, height: view.frame.height+250)
    }
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView ()
        scroll.frame = view.bounds
        scroll.showsVerticalScrollIndicator = false
        scroll.contentSize = contentSize
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let view = UIView ()
        view.frame.size = contentSize
        return view
    }()
    
    var profileImageView = ProfileImageView()
    
    let nameInputView: TextInputView = {
        let defaults = UserDefaults.standard
        let input = TextInputView()
        input.label.text            = "First Name"
        input.textField.text        = defaults.string(forKey: "firstName")
        input.textField.placeholder = "Enter first name"
        return input
    }()
    
    let surnameInputView: TextInputView = {
        let defaults = UserDefaults.standard
        let input = TextInputView()
        input.label.text            = "Last Name"
        input.textField.text        = defaults.string(forKey: "lastName")
        input.textField.placeholder = "Enter last name"
        return input
    }()
    
    let emailInputView: TextInputView = {
        let defaults = UserDefaults.standard
        let input = TextInputView()
        input.label.text            = "Email"
        input.textField.text        = defaults.string(forKey: "Email")
        input.textField.placeholder = "Enter email"
        input.textField.keyboardType = .emailAddress
        return input
    }()
    
    let dateInputView: ProfileDateInputView = {
        let defaults = UserDefaults.standard
        let input = ProfileDateInputView()
        input.label.text             = "Date of Birth"
        input.textField.text        = defaults.string(forKey: "dateOfBrith")
        input.textField.placeholder  = "Enter date of birth"
        return input
    }()
    
    let genderInputView: ProfileGenderInputView = {
        let input = ProfileGenderInputView()
        return input
    }()
    
    let locationInputView: TextInputView = {
        let input = TextInputView()
        input.label.text             = "Location"
        input.textField.placeholder  = "Enter location"
        return input
    }()
    
    var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        button.setTitleColor(Theme.grayColor, for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor    = #colorLiteral(red: 0.9258332849, green: 0.9457512498, blue: 0.9668992162, alpha: 1)
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        nameUser()
        configureView()
    }
    
    //MARK: - Configure Methods
    
    func configureView () {
        configureNavigationBar()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameInputView)
        contentView.addSubview(surnameInputView)
        contentView.addSubview(saveButton)
        contentView.addSubview(emailInputView)
        contentView.addSubview(dateInputView)
        contentView.addSubview(genderInputView)
        contentView.addSubview(locationInputView)
        setConstraints ()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Profile"
        navigationController?.navigationBar.barTintColor = .systemBackground
        
        let backButtonImage = UIImage(named: "backArrow")
        let backButton = UIBarButtonItem(image: backButtonImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(goBack))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.hidesBackButton = true
    }
    
    //MARK: - Objc Functions
    
    @objc func saveButtonPressed() {
        user.firstName = nameInputView.textField.text
        user.lastName = surnameInputView.textField.text
        user.dateOfBrith = dateInputView.textField.text
        let defaults = UserDefaults.standard
        defaults.set(user.firstName, forKey: "firstName")
        defaults.set(user.lastName, forKey: "lastName")
        defaults.set(user.dateOfBrith, forKey: "dateOfBrith")
        
        // Добавляем эффект нажатия
            UIButton.animate(withDuration: 0.2, animations: {
                self.saveButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }, completion: { _ in
                UIButton.animate(withDuration: 0.2) {
                    self.saveButton.transform = CGAffineTransform.identity
                }
            })
       
        
        print ("save changes pressed")
    }
    
    func nameUser() {
        let defaults = UserDefaults.standard
        let firstName = defaults.string(forKey: "firstName")
        let lastName = defaults.string(forKey: "lastName")
        
        if let firstName = firstName, let lastName = lastName {
            // Используйте имя и фамилию в приложении
            nameInputView.textField.text = firstName
            surnameInputView.textField.text = lastName
        }
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Set Constraints

extension ProfileViewController {
    func setConstraints () {
        let safeArea = view.safeAreaLayoutGuide
        let screenHeight = UIScreen.main.bounds.height
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint     (equalTo: contentView.topAnchor,     constant: 0),
            profileImageView.leadingAnchor.constraint (equalTo: contentView.leadingAnchor, constant: 0),
            profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 0),
            profileImageView.heightAnchor.constraint  (equalToConstant: screenHeight/6)
        ])
        
        NSLayoutConstraint.activate([
            nameInputView.topAnchor.constraint     (equalTo: profileImageView.bottomAnchor, constant: 0),
            nameInputView.leadingAnchor.constraint (equalTo: contentView.leadingAnchor, constant: 20),
            nameInputView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            nameInputView.heightAnchor.constraint  (equalToConstant: screenHeight/8)
        ])
        
        NSLayoutConstraint.activate([
            surnameInputView.topAnchor.constraint     (equalTo: nameInputView.bottomAnchor, constant: 0),
            surnameInputView.leadingAnchor.constraint (equalTo: contentView.leadingAnchor, constant: 20),
            surnameInputView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            surnameInputView.heightAnchor.constraint  (equalToConstant: screenHeight/8)
        ])
        
        NSLayoutConstraint.activate([
            emailInputView.topAnchor.constraint     (equalTo: surnameInputView.bottomAnchor, constant: 0),
            emailInputView.leadingAnchor.constraint (equalTo: contentView.leadingAnchor, constant: 20),
            emailInputView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            emailInputView.heightAnchor.constraint  (equalToConstant: screenHeight/8)
        ])
        
        NSLayoutConstraint.activate([
            dateInputView.topAnchor.constraint     (equalTo: emailInputView.bottomAnchor, constant: 0),
            dateInputView.leadingAnchor.constraint (equalTo: contentView.leadingAnchor, constant: 20),
            dateInputView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            dateInputView.heightAnchor.constraint  (equalToConstant: screenHeight/8)
        ])
        
        NSLayoutConstraint.activate([
            genderInputView.topAnchor.constraint     (equalTo: dateInputView.bottomAnchor, constant: 0),
            genderInputView.leadingAnchor.constraint (equalTo: contentView.leadingAnchor, constant: 20),
            genderInputView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            genderInputView.heightAnchor.constraint  (equalToConstant: screenHeight/8)
        ])
        
        NSLayoutConstraint.activate([
            locationInputView.topAnchor.constraint     (equalTo: genderInputView.bottomAnchor, constant: 0),
            locationInputView.leadingAnchor.constraint (equalTo: contentView.leadingAnchor, constant: 20),
            locationInputView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            locationInputView.heightAnchor.constraint  (equalToConstant: screenHeight/8)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint     (equalTo: locationInputView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint (equalTo: contentView.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint  (equalToConstant: screenHeight/17)
            
        ])
        
        
    }
}
