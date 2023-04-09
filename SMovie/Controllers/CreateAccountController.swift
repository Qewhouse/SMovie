//
//  CreateAccount.swift
//  SMovie




import UIKit

class CreateAccountController: UIViewController {
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
    let buttonGoogle:UIButton = {
        let button = UIButton()
        button.setTitle("Continue with Google", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
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
        //attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        alreadyLabel.attributedText = attributedString
        alreadyLabel.translatesAutoresizingMaskIntoConstraints = false
        alreadyLabel.isUserInteractionEnabled = true
        alreadyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginTapped)))
        return alreadyLabel
    }()
    
    //Обработка нажатия на кликабельную часть текса "Login"
    @objc func loginTapped() {
        // Handle login tap action here
    }


    
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
        setView()
        setConstraint()
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
    
}


extension CreateAccountController {
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            
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
            
            //constraints для alreadyLabel
            alreadyLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 497),
            alreadyLabel.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            
            //constraints для googleIconImageView
            googleIconImageView.leadingAnchor.constraint(equalTo: buttonGoogle.leadingAnchor, constant: 58.5),
            googleIconImageView.centerYAnchor.constraint(equalTo: buttonGoogle.centerYAnchor),
            googleIconImageView.widthAnchor.constraint(equalToConstant: 24),
            googleIconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}



