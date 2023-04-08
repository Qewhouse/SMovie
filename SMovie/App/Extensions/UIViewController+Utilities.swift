//
//  UIViewController+Utilities.swift
//  SMovie
//
//  Created by Alexander Altman on 01.04.2023.
//

import UIKit

extension UIViewController {
    
    func setStatusBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = Theme.appColor
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)
            ]
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    func setTabBar() {
        let tabBarAppearance = UITabBarAppearance()
//        tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        tabBarAppearance.backgroundColor = Theme.appColor
        tabBarAppearance.stackedItemPositioning = .centered
  
    }
}
