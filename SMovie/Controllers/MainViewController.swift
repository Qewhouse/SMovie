//
//  MainViewController.swift
//  SMovie
//
//  Created by Alexander Altman on 01.04.2023.
//

import UIKit

final class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }
}

extension MainViewController {
    private func setupViews() {
        let searchVC = SearchViewController()
        let playVC = PlayViewController()
        let homeVC = HomeViewController()
        let favouriteVC = FavouriteViewController()
        let personVC = PersonViewController()

        searchVC.setTabBarImage(imageName: "magnifyingglass", title: "search")
        playVC.setTabBarImage(imageName: "play.circle", title: "play")
        homeVC.setTabBarImage(imageName: "house", title: "home")
        favouriteVC.setTabBarImage(imageName: "heart.fill", title: "favorite")
        personVC.setTabBarImage(imageName: "person", title: "person")

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

