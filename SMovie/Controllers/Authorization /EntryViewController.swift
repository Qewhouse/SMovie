import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


class EntryViewController: UIViewController {
    
    let passwordToggleButton = UIButton(type: .system)
    
    // Установка надписи "Create account"
    let createAccountLabel: UILabel = {
        let createAccount = UILabel()
        createAccount.text = "Log in to your\nAccount" // измените текст на две строки
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
    
    // Добавление надписи "Email" на белый объект
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Добавление поля ввода email
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.backgroundColor = UIColor(named: "grayColor")
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.borderStyle = .none
        textField.layer.cornerRadius = 24
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    // Добавление надписи "Password" на белый объект
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Добавление поля ввода Password
    let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.backgroundColor = UIColor(named: "grayColor")
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        passwordTextField.borderStyle = .none
        passwordTextField.layer.cornerRadius = 24
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: passwordTextField.frame.height))
        passwordTextField.leftView = leftView
        passwordTextField.leftViewMode = .always
        
        return passwordTextField
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
    
    //Добавление кнопки "Login"
    lazy var buttonLogin: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(named: "violetColor")
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside )
        return button
    }()
    
    //Добавляем текст "Forgot password. Set a new one"
    lazy var forgotPasswordLabel: UILabel = {
        let alreadyLabel = UILabel()
        let string = "Forgot password. Set a new one"
        let attributedString = NSMutableAttributedString(string: string)
        let range = (string as NSString).range(of: "Set a new one")
        attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: range)
        alreadyLabel.attributedText = attributedString
        alreadyLabel.textAlignment = .center
        alreadyLabel.translatesAutoresizingMaskIntoConstraints = false
        alreadyLabel.isUserInteractionEnabled = true
        alreadyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resetTapped)))
        return alreadyLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Установка фона
        view.backgroundColor = UIColor(named: "violetColor")
        setView()
        configurePasswordToggleButton()
        setConstraint()
        
    }
    
    
    //Добавление в представление элементов пользовательского интерфейса
    func setView() {
        
        whiteView.addSubview(emailLabel)
        whiteView.addSubview(emailTextField)
        whiteView.addSubview(passwordTextField)
        whiteView.addSubview(lineView_Left)
        whiteView.addSubview(lineView_Right)
        whiteView.addSubview(continueLabel)
        whiteView.addSubview(buttonLogin)
        whiteView.addSubview(passwordLabel)
        whiteView.addSubview(forgotPasswordLabel)
        view.addSubview(createAccountLabel)
        view.addSubview(whiteView)
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
    
    // Обработчик нажатия на кнопку для авторизации
    @objc func tappedButton() {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let searchViewController = TabBarController()
                    self.navigationController?.pushViewController(searchViewController, animated: true)
                }
            }
        }
    }
    
    // Обработчик нажатия на текст "login"
    @objc func resetTapped() {
        let nextVC = PasswordRecovery()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}


extension EntryViewController {
    
    func setConstraint() {
        UIKit.NSLayoutConstraint.activate([
            
            //constraints для надписи "Create account"
            createAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 74),

            //constraints для белого View"
            whiteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 198),
            whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //constraints для emailLabel
            emailLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 70),
            emailLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 24),
            
            //constraints для emailTextField
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -24),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            emailTextField.widthAnchor.constraint(equalToConstant: 327),
            
            //constrain and passworsLabel
            passwordLabel.bottomAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 35),
            passwordLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 24),
            
            //constraints для buttonContinue
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 24),
            passwordTextField.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -24),
            passwordTextField.widthAnchor.constraint(equalToConstant: 327),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            
            //constraints для lineView_Left
            lineView_Left.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 43),
            lineView_Left.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 57),
            lineView_Left.widthAnchor.constraint(equalToConstant: 62),
            lineView_Left.heightAnchor.constraint(equalToConstant: 1),
            
            //constraints для lineView_Right
            lineView_Right.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 43),
            lineView_Right.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -57),
            lineView_Right.widthAnchor.constraint(equalToConstant: 62),
            lineView_Right.heightAnchor.constraint(equalToConstant: 1),
            
            //constraints для continueLabel
            continueLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32),
            continueLabel.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            
            //constraints для buttonLogin
            buttonLogin.topAnchor.constraint(equalTo: continueLabel.bottomAnchor, constant: 32),
            buttonLogin.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 24),
            buttonLogin.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -24),
            buttonLogin.widthAnchor.constraint(equalToConstant: 327),
            buttonLogin.heightAnchor.constraint(equalToConstant: 56),
            
            forgotPasswordLabel.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 24),
            forgotPasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            
        ])
    }
}




