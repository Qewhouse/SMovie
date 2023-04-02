//
//  TabBarController.swift
//  SMovie
//
//  Created by Alexander Altman on 01.04.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }
}

extension TabBarController {
    private func setupViews() {
        let searchVC = SearchViewController()
        let playVC = PlayViewController()
        let homeVC = HomeViewController()
        let favouriteVC = FavouriteViewController()
        let personVC = PersonViewController()

        searchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Search_alt"), selectedImage: UIImage(named: "Search_alt_fill"))
        playVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Video"), selectedImage: UIImage(named: "Video_fill"))
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), selectedImage: UIImage(named: "Home"))
        favouriteVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Favorite"), selectedImage: UIImage(named: "Favorite_fill"))
        personVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Profile"), selectedImage: UIImage(named: "Profile_fill"))
        
        let searchNC = UINavigationController(rootViewController: searchVC)
        let playNC = UINavigationController(rootViewController: playVC)
        let homeNC = UINavigationController(rootViewController: homeVC)
        let favouriteNC = UINavigationController(rootViewController: favouriteVC)
        let personNC = UINavigationController(rootViewController: personVC)
        
        let tabBarList = [searchNC, playNC, homeNC, favouriteNC, personNC]

        viewControllers = tabBarList
    }

    private func setupTabBar() {
        tabBar.clipsToBounds = true
        tabBar.tintColor = Theme.violetColor
        tabBar.unselectedItemTintColor = Theme.grayColor
        tabBar.isTranslucent = false
        tabBar.backgroundColor = Theme.appColor
    }
}
