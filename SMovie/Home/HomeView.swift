//
//  HomeView.swift
//  SMovie
//
//  Created by Вова on 09.04.2023.
//

import UIKit

class HomeView : UIView {
    
    //MARK: - Properties
    
    let topGreetView: UserInfoHeaderView = {
        let view = UserInfoHeaderView()
        let defaults = UserDefaults.standard
       
        if let firstName = UserDefaults.standard.string(forKey: "firstName"),
           let lastName = UserDefaults.standard.string(forKey: "lastName") {
            view.userNameLabel.text = "\(firstName) \(lastName),"
        } else {
            view.userNameLabel.text = "Unknown User,"
        }
      
        view.userMailLabel.text = "only streaming movie lovers"
        view.profileImageView.widthAnchor.constraint (equalToConstant: CGFloat(40)).isActive = true
        view.profileImageView.heightAnchor.constraint(equalToConstant: CGFloat(40)).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout ()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor(named: "appColor")
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
   
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Views

    private func setupViews() {
        backgroundColor = UIColor(named: "appColor")
        addSubview(topGreetView)
        addSubview(collectionView)
        

    }
    //MARK: - Constraints
    
    private func setConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        let screenHeight = UIScreen.main.bounds.height
        
        NSLayoutConstraint.activate([
            topGreetView.topAnchor.constraint     (equalTo: topAnchor, constant: 0),
            topGreetView.leadingAnchor.constraint (equalTo: safeArea.leadingAnchor, constant: 0),
            topGreetView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            topGreetView.heightAnchor.constraint  (equalToConstant: screenHeight/15)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint     (equalTo: topGreetView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint (equalTo: safeArea.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint  (equalTo: safeArea.bottomAnchor,constant: 0)
        ])
        
    }
    
}
