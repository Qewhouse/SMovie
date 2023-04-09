//
//  SignUpController.swift
//  SMovie


import UIKit

class SignUpController: UIViewController {
    
    // Создаем кнопки типа 'system' для переключения видимости пароля
    let passwordToggleButton = UIButton(type: .system)
    let confirmToggleButton = UIButton(type: .system)
    
    
    // Создаем текстовое поле для ввода имени
    let nameTextFiled: UITextField = {
        let nameTextFiled = UITextField()
        nameTextFiled.placeholder = "Enter your email address"
        nameTextFiled.backgroundColor = UIColor(named: "grayColor")
        nameTextFiled.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameTextFiled.layer.cornerRadius = 24
        nameTextFiled.translatesAutoresizingMaskIntoConstraints = false
        
        // Создаем UIView для добавления отступа слева
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: nameTextFiled.frame.height))
        nameTextFiled.leftView = paddingView
        nameTextFiled.leftViewMode = .always
        return nameTextFiled
    }()
    
    // Создаем Label для отображения заголовка фамилии
    let lastNameLabel: UILabel = {
        let lastNameLabel = UILabel()
        lastNameLabel.text = "Last Name"
        lastNameLabel.textColor = .gray
        lastNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return lastNameLabel
    }()
    
    // Создаем текстовое поле для ввода фамилии
    let lastNameTextFiled: UITextField = {
        let lastNameTextFiled = UITextField()
        lastNameTextFiled.placeholder = "Enter your name"
        lastNameTextFiled.backgroundColor = UIColor(named: "grayColor")
        lastNameTextFiled.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        lastNameTextFiled.layer.cornerRadius = 24
        lastNameTextFiled.translatesAutoresizingMaskIntoConstraints = false
        
        // Создаем UIView для добавления отступа слева
        let indentView1 = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: lastNameTextFiled.frame.height))
        lastNameTextFiled.leftView = indentView1
        lastNameTextFiled.leftViewMode = .always
        
        return lastNameTextFiled
    }()
    
    //Добавление "E-maill"
    let emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.text = "E-mail"
        emailLabel.textColor = .gray
        emailLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        return emailLabel
    }()
    
    // Создаем текстовое поле для ввода email
    let emailTextFiled: UITextField = {
        let emailTextFiled = UITextField()
        emailTextFiled.placeholder = "Enter your email"
        emailTextFiled.backgroundColor = UIColor(named: "grayColor")
        emailTextFiled.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emailTextFiled.layer.cornerRadius = 24
        emailTextFiled.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Создаем UIView для добавления отступа слева
        let indentView2 = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: emailTextFiled.frame.height))
        emailTextFiled.leftView = indentView2
        emailTextFiled.leftViewMode = .always
        
        return emailTextFiled
    }()
    
    //Добавление "Password"
    let passwordNameLabel: UILabel = {
        let passwordNameLabel = UILabel()
        passwordNameLabel.text = "Password"
        passwordNameLabel.textColor = .gray
        passwordNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        passwordNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return passwordNameLabel
    }()
    
    //Создаем поля ввода для "Password"
    let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = UIColor(named: "grayColor")
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        passwordTextField.layer.cornerRadius = 24
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Создаем UIView для добавления отступа слева
        let indentView3 = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: passwordTextField.frame.height))
        passwordTextField.leftView = indentView3
        passwordTextField.leftViewMode = .always
        
        return passwordTextField
    }()
    
    //Добавление "Confirm Password"
    let confirmLabel: UILabel = {
        let confirmLabel = UILabel()
        confirmLabel.text = "Confirm Password"
        confirmLabel.textColor = .gray
        confirmLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        confirmLabel.translatesAutoresizingMaskIntoConstraints = false
        return confirmLabel
    }()
    
    //Создаем поля ввода для "Confirm Password"
    let confirmTextField: UITextField = {
        let confirmTextField = UITextField()
        confirmTextField.placeholder = "Enter your password"
        confirmTextField.isSecureTextEntry = true
        confirmTextField.backgroundColor = UIColor(named: "grayColor")
        confirmTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        confirmTextField.layer.cornerRadius = 24
        confirmTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Создаем UIView для добавления отступа слева
        let indentView4 = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: confirmTextField.frame.height))
        confirmTextField.leftView = indentView4
        confirmTextField.leftViewMode = .always
        return confirmTextField
    }()
    
    // Добавление кнопки "Sign Up"
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(named: "violetColor")
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //Добавляем текст "Already have an account? Login"
    lazy var alreadyLabel: UILabel = {
        let alreadyLabel = UILabel()
        let string = "Already have an account? Login"
        let attributedString = NSMutableAttributedString(string: string)
        let range = (string as NSString).range(of: "Login")
        attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: range)
        alreadyLabel.attributedText = attributedString
        alreadyLabel.textAlignment = .center
        alreadyLabel.translatesAutoresizingMaskIntoConstraints = false
        alreadyLabel.isUserInteractionEnabled = true
        alreadyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginTapped)))
        return alreadyLabel
    }()
    
    //Создаем Label "Complet your account"
    let completLabel: UILabel = {
        let label = UILabel()
        label.text = "Complet your account"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Создаем Label "Lorem ipsum dolor sit amet"
    let loremLabel: UILabel = {
        let label = UILabel()  //(frame: CGRect(x: 0, y: 180, width: view.frame.width, height: 22))
        label.text = "Lorem ipsum dolor sit amet"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //Создаем Label "First Name"
    let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sign Up"
        
        setView()
        configurePasswordToggleButton()
        confirmPasswordToggleButton()
        setConstraint()
        configureNavigationBar() 
        
    }
    
    
    //Добавление в представление элементов пользовательского интерфейса
    func setView() {
        view.addSubview(nameTextFiled)
        
        view.addSubview(lastNameLabel)
        
        view.addSubview(lastNameTextFiled)
        
        view.addSubview(emailLabel)
        
        view.addSubview(emailTextFiled)
        
        view.addSubview(passwordNameLabel)
        
        view.addSubview(passwordTextField)
        
        view.addSubview(confirmLabel)
        
        view.addSubview(confirmTextField)
        
        view.addSubview(button)
        
        view.addSubview(alreadyLabel)
        
        view.addSubview(loremLabel)
        
        view.addSubview(firstNameLabel)
        
        view.addSubview(completLabel)
        
    }
    
    // Настраиваем переключатель видимости пароля в поле ввода
    func configurePasswordToggleButton() {
        passwordToggleButton.tintColor = .gray
        passwordToggleButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 17.5)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        passwordTextField.rightView = passwordToggleButton
        passwordTextField.rightViewMode = .always
    }
    
    // Функция переключения видимости текста пароля, меняет иконку кнопки.
    @objc  func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let isSecure = passwordTextField.isSecureTextEntry
        let imageName = isSecure ? "eye.slash" : "eye"
        passwordToggleButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    // Обработчик нажатия на кнопку для показа пароля
    @objc func showPasswordButtonTapped(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    // Настраиваем навигационную панель, добавляем кнопку возврата.
    func configureNavigationBar() {
        let backButtonImage = UIImage(named: "ArrowBack")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressed))

        self.navigationItem.leftBarButtonItem = backButton
        }
    
    // Обработчик нажатия на кнопку возврата, возвращает пользователя на предыдущий экран
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Настраиваем переключатель видимости пароля в поле ввода
    func confirmPasswordToggleButton() {
        confirmToggleButton.tintColor = .gray
        confirmToggleButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 17.5)
        confirmToggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        confirmToggleButton.addTarget(self, action: #selector(toggleСonfirmVisibility), for: .touchUpInside)
        confirmTextField.rightView = confirmToggleButton
        confirmTextField.rightViewMode = .always
    }
    
    // Функция переключения видимости текста пароля, меняет иконку кнопки.
    @objc  func toggleСonfirmVisibility() {
        confirmTextField.isSecureTextEntry.toggle()
        let isSecure = confirmTextField.isSecureTextEntry
        let imageName = isSecure ? "eye.slash" : "eye"
        confirmToggleButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    // Обработчик нажатия на кнопку для показа пароля
    @objc func showСonfirmButtonTapped(_ sender: UIButton) {
        confirmTextField.isSecureTextEntry.toggle()
    }
    
    
    // Обработчик нажатия на кликабельный текст "Login"
    @objc func loginTapped() {
        // Обработчик нажатия на кнопку
    }
    
    
}

extension SignUpController {
    
    func setConstraint() {
        NSLayoutConstraint.activate ([
            
            nameTextFiled.topAnchor.constraint(equalTo: view.topAnchor, constant: 264),
            nameTextFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameTextFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            nameTextFiled.heightAnchor.constraint(equalToConstant: 52),
            
            lastNameLabel.topAnchor.constraint(equalTo: nameTextFiled.bottomAnchor, constant: 16),
            lastNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            loremLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loremLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            loremLabel.widthAnchor.constraint(equalToConstant: 209),
            loremLabel.heightAnchor.constraint(equalToConstant: 24),
            
            completLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            completLabel.widthAnchor.constraint(equalToConstant: 264),
            completLabel.heightAnchor.constraint(equalToConstant: 32),
            
            firstNameLabel.topAnchor.constraint(equalTo: loremLabel.bottomAnchor, constant: 32),
            firstNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            lastNameTextFiled.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 8),
            lastNameTextFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            lastNameTextFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            lastNameTextFiled.heightAnchor.constraint(equalToConstant: 52),
            
            emailLabel.topAnchor.constraint(equalTo: lastNameTextFiled.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            emailTextFiled.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailTextFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailTextFiled.heightAnchor.constraint(equalToConstant: 52),
            
            passwordNameLabel.topAnchor.constraint(equalTo: emailTextFiled.bottomAnchor, constant: 16),
            passwordNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordNameLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),
            
            confirmLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            confirmLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            confirmTextField.topAnchor.constraint(equalTo: confirmLabel.bottomAnchor, constant: 8),
            confirmTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            confirmTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            confirmTextField.heightAnchor.constraint(equalToConstant: 52),
            
            button.topAnchor.constraint(equalTo: confirmTextField.bottomAnchor, constant: 24),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            button.widthAnchor.constraint(equalToConstant: 327),
            button.heightAnchor.constraint(equalToConstant: 56),
            
            alreadyLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 24),
            alreadyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

