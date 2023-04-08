//
//  ForgotPasswordViewController.swift
//  SMovie
//
//  Created by Вова on 08.04.2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "key")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your email for the verification process, we will send you a code"
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.5411760807, green: 0.5411768556, blue: 0.5583735108, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var emailInputView: TextInputView = {
        let input = TextInputView()
        input.label.text            = "E-mail"
        input.textField.placeholder = "Enter email address"
        input.textField.keyboardType = .emailAddress
        input.textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return input
    }()
    
    var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.5411760807, green: 0.5411768556, blue: 0.5583735108, alpha: 1), for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor    = #colorLiteral(red: 0.9258332849, green: 0.9457512498, blue: 0.9668992162, alpha: 1)
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        emailInputView.textField.delegate = self
    }
    
    //MARK: - Configure Methods
    
    func configureView () {
        view.backgroundColor = .white
        configureNavigationBar()
        view.addSubview(iconImageView)
        view.addSubview(descriptionLabel)
        view.addSubview(emailInputView)
        view.addSubview(continueButton)
        setConstraints ()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Forgot Password"
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
    
    //MARK: - TextField Delegate Methods

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return emailInputView.textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    //MARK: - Objc Functions
    
    @objc func saveButtonPressed() {
        print ("Continue pressed")
    }
    
    @objc func goBack() {
    navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange() {
        let text = emailInputView.textField.text?.count
        
        if text!>1 {
            continueButton.setTitleColor(UIColor(named: "violetColor"), for: .normal)
            continueButton.layer.cornerRadius = 25
            continueButton.layer.borderWidth  = 2.0
            continueButton.backgroundColor    = UIColor(named: "appColor")
            continueButton.layer.borderColor  = UIColor(named: "violetColor")?.cgColor
        }
    }
}

//MARK: - Set Constraints

extension ForgotPasswordViewController {
    func setConstraints () {
        let safeArea = view.safeAreaLayoutGuide
        let screenHeight = UIScreen.main.bounds.height
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint     (equalTo: safeArea.topAnchor,     constant: 20),
            iconImageView.leadingAnchor.constraint (equalTo: safeArea.leadingAnchor, constant: 20),
            iconImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -20),
            iconImageView.heightAnchor.constraint  (equalToConstant: screenHeight/8)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint     (equalTo: iconImageView.bottomAnchor,     constant: 0),
            descriptionLabel.leadingAnchor.constraint (equalTo: safeArea.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -20),
            descriptionLabel.heightAnchor.constraint  (equalToConstant: screenHeight/8)
        ])
        
        NSLayoutConstraint.activate([
            emailInputView.topAnchor.constraint     (equalTo: descriptionLabel.bottomAnchor, constant: 0),
            emailInputView.leadingAnchor.constraint (equalTo: safeArea.leadingAnchor, constant: 20),
            emailInputView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -20),
            emailInputView.heightAnchor.constraint  (equalToConstant: screenHeight/8)
        ])
              
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint  (equalTo: safeArea.bottomAnchor, constant: -20),
            continueButton.leadingAnchor.constraint (equalTo: safeArea.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint  (equalToConstant: screenHeight/17)
            
        ])
    }
}