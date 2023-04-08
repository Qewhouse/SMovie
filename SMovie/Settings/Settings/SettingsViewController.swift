//
//  PersonViewController.swift
//  SMovie
//
//  Created by Alexander Altman on 01.04.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    //MARK: - Properties

    var sections  = [Section]()
    
    var tableView = UITableView()
    
    var userInfoHeader = UserInfoHeaderView()
    
    var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(UIColor(named: "violetColor"), for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth  = 2.0
        button.backgroundColor    = UIColor(named: "appColor")
        button.layer.borderColor  = UIColor(named: "violetColor")?.cgColor
        button.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func logOutButtonPressed() {
        print ("log out pressed")
    
    }
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSections()
        configureView()
    }
    
    //MARK: - Configure methods

    func configureView() {
        view.addSubview(tableView)
        view.addSubview(userInfoHeader)
        view.addSubview(logOutButton)
        configureNavigationBar()
        configureTableView()
        setConstraints()
        userInfoHeader.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func configureTableView () {
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.rowHeight  = 60
        tableView.showsVerticalScrollIndicator              = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(SettingCell.self,
                           forCellReuseIdentifier: SettingCell.reuseIdentifier)
        tableView.register(SettingSwitchCell.self,
                           forCellReuseIdentifier: SettingSwitchCell.reuseIdentifier)
        tableView.frame = view.frame
    }
    

    
    func configureSections () {
        sections.append(Section(title: "Personal Info",
                                options: [.staticCell(model: SettingsModel(title: "Profile",
                                                                           icon: UIImage(named: "profileIcon")!,
                                                                           handler: {
            let profileVC: ProfileViewController = ProfileViewController()
            self.navigationController?.pushViewController(profileVC, animated: true)

        }))]))
        
        sections.append(Section(title: "Security",
                                options: [.staticCell(model: SettingsModel(title: "Change password",
                                                                           icon: UIImage(named: "passwordLockedIcon")!,
                                                                           handler: {
            let changePasswordVC: ChangePasswordViewController = ChangePasswordViewController()
            self.navigationController?.pushViewController(changePasswordVC, animated: true)
        })),
                                          
                                          .staticCell(model: SettingsModel(title: "Forgot password",
                                                                           icon: UIImage(named: "passwordIcon")!,
                                                                           handler: {
            let forgotPasswordVC: ForgotPasswordViewController = ForgotPasswordViewController()
            self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
        }))
        ]))
        
        sections.append(Section(title: "App Theme",
                                options: [.switchCell(model: SettingsSwitchModel(title: "Dark Mode",
                                                                                 icon: UIImage(named: "darkmodeIcon")!,
                                                                                 handler: {},
                                                                                 isOn: false))]))
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.barTintColor = .systemBackground
    
    }
}

//MARK: - TableView Delegates

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = sections[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let staticModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier, for: indexPath) as! SettingCell
            cell.configure(with: staticModel)
            return cell
        case .switchCell(let switchModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingSwitchCell.reuseIdentifier, for: indexPath) as! SettingSwitchCell
            cell.configure(with: switchModel)
            return cell
        }
           }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = sections[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let staticModel): staticModel.handler()
        case .switchCell(let switchModel): switchModel.handler()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Constraints

extension SettingsViewController {
    func setConstraints () {
        let safeArea = view.safeAreaLayoutGuide
        let screenHeight = UIScreen.main.bounds.height
        
        NSLayoutConstraint.activate([
            userInfoHeader.topAnchor.constraint     (equalTo: safeArea.topAnchor, constant: 0),
            userInfoHeader.leadingAnchor.constraint (equalTo: safeArea.leadingAnchor, constant: 0),
            userInfoHeader.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            userInfoHeader.heightAnchor.constraint  (equalToConstant: screenHeight/8)
        ])
        
        NSLayoutConstraint.activate([
            logOutButton.bottomAnchor.constraint    (equalTo: safeArea.bottomAnchor, constant: -60),
            logOutButton.leadingAnchor.constraint   (equalTo: safeArea.leadingAnchor, constant: 50),
            logOutButton.trailingAnchor.constraint  (equalTo: safeArea.trailingAnchor, constant: -50),
            logOutButton.heightAnchor.constraint    (equalToConstant: screenHeight/18)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint     (equalTo: userInfoHeader.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint (equalTo: safeArea.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint  (equalTo: logOutButton.topAnchor, constant: -40)
            
        ])
    }
}




