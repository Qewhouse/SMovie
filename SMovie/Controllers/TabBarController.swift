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

        searchVC.setTabBarImage(imageName: "magnifyingglass", title: "")
        playVC.setTabBarImage(imageName: "play.circle", title: "")
        homeVC.setTabBarImage(imageName: "house", title: "")
        favouriteVC.setTabBarImage(imageName: "heart.fill", title: "")
        personVC.setTabBarImage(imageName: "person", title: "")

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
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
        tabBar.isTranslucent = false
    }
}

