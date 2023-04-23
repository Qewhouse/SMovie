

//
//  CreateAccount.swift
//  SMovie




import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


class SignController: UIViewController {
    
    
    

    // MARK: - Объекты
    // Установка надписи "Create account"
    let createAccountLabel: UILabel = {
        let createAccount = UILabel()
        createAccount.text = "Create account"
        createAccount.textAlignment = .center
        createAccount.backgroundColor = .clear
        createAccount.layer.cornerRadius = 0
        createAccount.textColor = .white
        createAccount.font = UIFont.systemFont(ofSize: 24, weight: .bold)
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
    
    // Добавление поля ввода email на белый объект
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
    
    // Добавление кнопки "Continue with Email"
    let buttonContinue: UIButton = {
        let button = UIButton()
        button.setTitle("Continue with Email", for: .normal)
        button.backgroundColor = UIColor(named: "violetColor")
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedContinue), for: .touchUpInside)
        return button
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
        label.text = "Or continue with"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Добавление кнопки "Continue with Google"
    lazy var buttonGoogle: UIButton = {
        let button = UIButton()
        button.setTitle("Continue with Google", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
        
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
    
    
    
    
    //Добавление изображения "Icon - Google"
    let googleIconImageView: UIImageView = {
        let googleIconImageView = UIImageView(image: UIImage(named: "Icon - Google"))
        googleIconImageView.contentMode = .scaleAspectFit
        googleIconImageView.translatesAutoresizingMaskIntoConstraints = false
        return googleIconImageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Установка фона
        view.backgroundColor = UIColor(named: "violetColor")
        
        //Функция для проверки пользователя
        checkCurrentUser()
        
        setView()
        setConstraint()
        
    }
    
    // Функция для проверки пользователя, входил он в приложение ранее или нет
    func checkCurrentUser() {
        if Auth.auth().currentUser != nil {
            let nextVC = TabBarController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        }

    }
    
    //Добавление в представление элементов пользовательского интерфейса
    func setView() {
        
        whiteView.addSubview(emailLabel)
        whiteView.addSubview(emailTextField)
        whiteView.addSubview(buttonContinue)
        whiteView.addSubview(lineView_Left)
        whiteView.addSubview(lineView_Right)
        whiteView.addSubview(continueLabel)
        buttonGoogle.addSubview(googleIconImageView)
        whiteView.addSubview(buttonGoogle)
        whiteView.addSubview(alreadyLabel)
        view.addSubview(createAccountLabel)
        view.addSubview(stayUpLabel)
        view.addSubview(whiteView)
    }
    
    
    @objc func tappedContinue() {
        //проверка корректного ввода email
        guard let email = emailTextField.text, isValidEmail(email) else {
            // Выводим сообщение об ошибке, если email не корректный
            let alert = UIAlertController(title: "Error", message: "Please enter a valid email address", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        //Запоминаем емайл
        let user = User()
        user.email = emailTextField.text
        let defaults = UserDefaults.standard
        defaults.set(user.email, forKey: "Email")
        
        // Если email корректный, то переходим на экран для создания аккаунта
        let nextVC = AccountCreationController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }



    func isValidEmail(_ email: String) -> Bool {
        // Регулярное выражение для проверки правильности ввода email
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        // Создаем NSPredicate на основе регулярного выражения
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        
        return emailPredicate.evaluate(with: email)
    }

    
    //Обработка нажатия кнопки "Continue with Google"
    @objc func didTapGoogleButton() {
        // Создаём объект конфигурации Google Sign-In
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) {[unowned self] result, error in
            if let error = error {
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("Invalid Google Sign-In authentication")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                // Работа с результатом аутентификации Firebase
                if error == nil {
                    // Аутентификация успешна, выполняем переход
                    let homeVC = HomeViewController()
                    self.navigationController?.pushViewController(homeVC, animated: true)
                } else {
                    // error message
                    print("Authentication failed: \(error!.localizedDescription)")
                }
            }
        }
    }
    
    // Обработчик нажатия на текст "login"
    @objc func loginTapped() {
        let nextVC = EntryViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
}


extension SignController {
    
    func setConstraint() {
        UIKit.NSLayoutConstraint.activate([
            
            //constraints для надписи "Create account"
            createAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 74),
            createAccountLabel.widthAnchor.constraint(equalToConstant: 184),
            createAccountLabel.heightAnchor.constraint(equalToConstant: 32),
            
            //constraints для надписи stayUpLabel
            stayUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stayUpLabel.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 8),
            stayUpLabel.widthAnchor.constraint(equalToConstant: 209),
            stayUpLabel.heightAnchor.constraint(equalToConstant: 24),
            
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
            
            //constraints для buttonContinue
            buttonContinue.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 32),
            buttonContinue.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 24),
            buttonContinue.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -24),
            buttonContinue.widthAnchor.constraint(equalToConstant: 327),
            buttonContinue.heightAnchor.constraint(equalToConstant: 56),
            
            //constraints для lineView_Left
            lineView_Left.topAnchor.constraint(equalTo: buttonContinue.bottomAnchor, constant: 43),
            lineView_Left.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 57),
            lineView_Left.widthAnchor.constraint(equalToConstant: 62),
            lineView_Left.heightAnchor.constraint(equalToConstant: 1),
            
            //constraints для lineView_Right
            lineView_Right.topAnchor.constraint(equalTo: buttonContinue.bottomAnchor, constant: 43),
            lineView_Right.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -57),
            lineView_Right.widthAnchor.constraint(equalToConstant: 62),
            lineView_Right.heightAnchor.constraint(equalToConstant: 1),
            
            //constraints для continueLabel
            continueLabel.topAnchor.constraint(equalTo: buttonContinue.bottomAnchor, constant: 32),
            continueLabel.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            
            //constraints для buttonGoogle
            
            buttonGoogle.topAnchor.constraint(equalTo: continueLabel.bottomAnchor, constant: 32),
            buttonGoogle.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 24),
            buttonGoogle.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -24),
            buttonGoogle.widthAnchor.constraint(equalToConstant: 327),
            buttonGoogle.heightAnchor.constraint(equalToConstant: 56),
            
            alreadyLabel.topAnchor.constraint(equalTo: buttonGoogle.bottomAnchor, constant: 24),
            alreadyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //constraints для googleIconImageView
            
            googleIconImageView.leadingAnchor.constraint(equalTo: buttonGoogle.leadingAnchor, constant: 58.5),
            googleIconImageView.centerYAnchor.constraint(equalTo: buttonGoogle.centerYAnchor),
            googleIconImageView.widthAnchor.constraint(equalToConstant: 24),
            googleIconImageView.heightAnchor.constraint(equalToConstant: 24)
            
        ])
    }
}



