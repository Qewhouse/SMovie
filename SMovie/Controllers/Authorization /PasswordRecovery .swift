//
//  PasswordRecovery .swift
//  SMovie
//
//  Created by Batman 👀 on 13.04.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


class PasswordRecovery : UIViewController {
    
    let passwordToggleButton = UIButton(type: .system)
    
    // Установка надписи "Create account"
    let resetPasswordLabel: UILabel = {
        let createAccount = UILabel()
        createAccount.text = "Reset password" // измените текст на две строки
        createAccount.textAlignment = .center
        createAccount.backgroundColor = .clear
        createAccount.layer.cornerRadius = 0
        createAccount.textColor = .white
        createAccount.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        createAccount.numberOfLines = 2 // установите количество строк на 2
        createAccount.translatesAutoresizingMaskIntoConstraints = false
       

        return createAccount
    }()

    
    // Установка надписи "Stay up to date"
    let stayUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Stay up to date"
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.layer.cornerRadius = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Добавление белого объекта
    let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//
    
    // Добавление надписи "Password" на белый объект
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Добавление поля ввода Password
    let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = "Enter your Email"
        emailTextField.backgroundColor = UIColor(named: "grayColor")
        emailTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emailTextField.borderStyle = .none
        emailTextField.layer.cornerRadius = 24
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: emailTextField.frame.height))
        emailTextField.leftView = leftView
        emailTextField.leftViewMode = .always
        
        return emailTextField
    }()
    
    //Добавление линии с лева
    let lineView_Left: UIView = {
        let left = UIView()
        left.backgroundColor = .gray
        left.translatesAutoresizingMaskIntoConstraints = false
        return left
    }()
    
    //Добавление линии с права
    let lineView_Right: UIView = {
        let right = UIView()
        right.backgroundColor = .gray
        right.translatesAutoresizingMaskIntoConstraints = false
        return right
    }()
    
    //Добавление "Or continue with"
    let continueLabel:UILabel = {
        let label = UILabel()
        label.text = "click on the button"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Добавление кнопки "Reset"
    lazy var buttonLogin: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.backgroundColor = UIColor(named: "violetColor")
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside )
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Установка фона
        view.backgroundColor = UIColor(named: "violetColor")
        setView()
        setConstraint()
        
    }
    
    
    //Добавление в представление элементов пользовательского интерфейса
    func setView() {
        
        
        whiteView.addSubview(emailTextField)
        whiteView.addSubview(lineView_Left)
        whiteView.addSubview(lineView_Right)
        whiteView.addSubview(continueLabel)
        whiteView.addSubview(buttonLogin)
        whiteView.addSubview(emailLabel)
        view.addSubview(resetPasswordLabel)
        view.addSubview(stayUpLabel)
        view.addSubview(whiteView)
    }
    

    // Обработчик нажатия на кнопку для авторизации
    @objc func tappedButton() {
        guard let email = emailTextField.text else { return }
    
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                // Обработка ошибок
                let alertController = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true)
            } else {
    
                let nextVC = EntryViewController()
                self.navigationController?.pushViewController(nextVC, animated: true)
    
                // Успешно отправлено письмо со ссылкой на сброс пароля
                let alertController = UIAlertController(title: "Успех", message: "Письмо со ссылкой на сброс пароля было отправлено на \(email)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true)
    
            }
        }
    }
    
}



extension PasswordRecovery {
    
    func setConstraint() {
        UIKit.NSLayoutConstraint.activate([
            
            //constraints для надписи "resetPasswordLabel"
            resetPasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetPasswordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 74),
            
            //constraints для надписи "Stay up to date"
            stayUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stayUpLabel.topAnchor.constraint(equalTo: resetPasswordLabel.bottomAnchor, constant: 8),
            stayUpLabel.widthAnchor.constraint(equalToConstant: 209),
            stayUpLabel.heightAnchor.constraint(equalToConstant: 24),

            //constraints для белого View"
            whiteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 198),
            whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            

            //constrain and emailLabel
            emailLabel.bottomAnchor.constraint(equalTo: whiteView.topAnchor, constant: 100),
            emailLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 24),
            
            //constraints для emailTextField
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -24),
            emailTextField.widthAnchor.constraint(equalToConstant: 327),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            
            //constraints для lineView_Left
            lineView_Left.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 43),
            lineView_Left.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 57),
            lineView_Left.widthAnchor.constraint(equalToConstant: 62),
            lineView_Left.heightAnchor.constraint(equalToConstant: 1),
            
            //constraints для lineView_Right
            lineView_Right.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 43),
            lineView_Right.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -57),
            lineView_Right.widthAnchor.constraint(equalToConstant: 62),
            lineView_Right.heightAnchor.constraint(equalToConstant: 1),
            
            //constraints для continueLabel
            continueLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 32),
            continueLabel.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            
            //constraints для buttonLogin
            buttonLogin.topAnchor.constraint(equalTo: continueLabel.bottomAnchor, constant: 32),
            buttonLogin.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 24),
            buttonLogin.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -24),
            buttonLogin.widthAnchor.constraint(equalToConstant: 327),
            buttonLogin.heightAnchor.constraint(equalToConstant: 56),
            
            
            
        ])
    }
}








//@objc func tappedButton() {
//    guard let email = emailTextField.text else { return }
//
//    Auth.auth().sendPasswordReset(withEmail: email) { error in
//        if let error = error {
//            // Обработка ошибок
//            let alertController = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: .default))
//            self.present(alertController, animated: true)
//        } else {
//
//            let nextVC = EntryViewController()
//            self.navigationController?.pushViewController(nextVC, animated: true)
//
//            // Успешно отправлено письмо со ссылкой на сброс пароля
//            let alertController = UIAlertController(title: "Успех", message: "Письмо со ссылкой на сброс пароля было отправлено на \(email)", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: .default))
//            self.present(alertController, animated: true)
//
//
//
//        }
//    }
//}
//



