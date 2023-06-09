//
//  ChangePasswordViewController.swift
//  SMovie
//
//  Created by Вова on 08.04.2023.
//

import UIKit
import FirebaseAuth

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {
    
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
        label.text = "Your new password must be different from the previous one"
        label.numberOfLines = 0
        label.textColor = Theme.fieldGrey
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currentPasswordView: TextInputView = {
        let input = TextInputView()
        input.label.text            = "Current Password"
        input.textField.placeholder = "Enter password"
        input.textField.isSecureTextEntry = true
        return input
    }()
    
    let newPasswordView: TextInputView = {
        let input = TextInputView()
        input.label.text            = "New Password"
        input.textField.placeholder = "Enter password"
        input.textField.isSecureTextEntry = true
        return input
    }()
    
    let confirmPasswordView: TextInputView = {
        let input = TextInputView()
        input.label.text            = "Confirm Password"
        input.textField.placeholder = "Enter password"
        input.textField.keyboardType = .emailAddress
        input.textField.isSecureTextEntry = true
        return input
    }()
    
    var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        button.setTitleColor(Theme.grayColor, for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor    = Theme.grayAndViolet
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureDelegates()
    }
    
    //MARK: - Configure Methods
    
    func configureView () {
        view.backgroundColor = Theme.appColor
        configureNavigationBar()
        view.addSubview(iconImageView)
        view.addSubview(descriptionLabel)
        view.addSubview(currentPasswordView)
        view.addSubview(newPasswordView)
        view.addSubview(confirmPasswordView)
        view.addSubview(saveButton)
        setConstraints ()
    }
    
    func configureDelegates () {
        currentPasswordView.textField.delegate = self
        newPasswordView.textField.delegate     = self
        confirmPasswordView.textField.delegate = self
        
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Change Password"
        navigationController?.navigationBar.barTintColor = .systemBackground
        
        let backButtonImage = UIImage(named: "backArrow")
        let backButton = UIBarButtonItem(image: backButtonImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(goBack))
        backButton.tintColor = Theme.reversedAppColor
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.hidesBackButton = true
    }
    
    //MARK: - TextField Delegate Methods

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return currentPasswordView.textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
  
    //MARK: - Objc Functions
    
    @objc func saveButtonPressed() {
        update()
        
        // Добавляем эффект нажатия
            UIButton.animate(withDuration: 0.2, animations: {
                self.saveButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }, completion: { _ in
                UIButton.animate(withDuration: 0.2) {
                    self.saveButton.transform = CGAffineTransform.identity
                }
            })
    }
    
    @objc func goBack() {
    navigationController?.popViewController(animated: true)
    }
    
    func update() {
        let oldPassword = currentPasswordView.textField.text
        let newPassword = newPasswordView.textField.text
        let confirmPassword = confirmPasswordView.textField.text
        
        
        guard let user = Auth.auth().currentUser else {
            
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: user.email!, password: oldPassword ?? "")
        
        // Повторная аутентификация пользователя со старым паролем перед обновлением пароля
        user.reauthenticate(with: credential) { _, error in
            if let error = error {
                // Обработка ошибки если старый пароль введен не верно
                self.showAlert(title: "Error", message: error.localizedDescription)
            } else {
                if oldPassword != newPassword {
                    if newPassword == confirmPassword {
                        // Обновляем пароль
                        user.updatePassword(to: newPassword ?? "") { error in
                            if let error = error {
                                // Ошибка обновления пароля
                                self.showAlert(title: "Error", message: error.localizedDescription)
                            } else {
                                // Успешное обновление пароля
                                self.showAlert(title: "Success", message: "Your password has been successfully updated.")
                            }
                        }
                    } else {
                        // Обработка ошибки если новые пароли не совподают
                        self.showAlert(title: "Error", message: "Passwords do not match.")
                    }
                } else {
                    // Обработка ошибки если совпадают старый и новый пароль
                    self.showAlert(title: "Error", message: "New password must be different from the old password.")
                }
            }
        }
    }
        
        //Уведомление
        func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
}

//MARK: - Set Constraints

extension ChangePasswordViewController {
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
            currentPasswordView.topAnchor.constraint     (equalTo: descriptionLabel.bottomAnchor, constant: 0),
            currentPasswordView.leadingAnchor.constraint (equalTo: safeArea.leadingAnchor, constant: 20),
            currentPasswordView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -20),
            currentPasswordView.heightAnchor.constraint  (equalToConstant: screenHeight/8)
        ])
        
        NSLayoutConstraint.activate([
            newPasswordView.topAnchor.constraint     (equalTo: currentPasswordView.bottomAnchor, constant: 0),
            newPasswordView.leadingAnchor.constraint (equalTo: safeArea.leadingAnchor, constant: 20),
            newPasswordView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -20),
            newPasswordView.heightAnchor.constraint  (equalToConstant: screenHeight/8)
        ])
        
        NSLayoutConstraint.activate([
            confirmPasswordView.topAnchor.constraint     (equalTo: newPasswordView.bottomAnchor, constant: 0),
            confirmPasswordView.leadingAnchor.constraint (equalTo: safeArea.leadingAnchor, constant: 20),
            confirmPasswordView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -20),
            confirmPasswordView.heightAnchor.constraint  (equalToConstant: screenHeight/8)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint  (equalTo: safeArea.bottomAnchor, constant: -20),
            saveButton.leadingAnchor.constraint (equalTo: safeArea.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint  (equalToConstant: screenHeight/17)
            
        ])
        

    }
}

