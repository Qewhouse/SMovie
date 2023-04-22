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
        self.selectedIndex = 2
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.tabBarController?.selectedIndex = 2
//    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        let orderedTabBarItemViews: [UIView] = {
                let interactionViews = tabBar.subviews.filter({ $0 is UIControl })
                return interactionViews.sorted(by: { $0.frame.minX < $1.frame.minX })
            }()

            guard
                let index = tabBar.items?.firstIndex(of: item),
                let subview = orderedTabBarItemViews[index].subviews.first
            else {
                return
            }
            performSpringAnimation(for: subview)
    }
    
    func performSpringAnimation(for view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            view.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }, completion: nil)
    }
}

extension TabBarController {
    private func setupViews() {
        let searchVC = SearchViewController()
        let playVC = PlayViewController()
        let homeVC = HomeViewController()
        let favouriteVC = FavouriteViewController()
        let personVC = DetailViewController(id: 550, mediaType: .movie)

        searchVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Search"), selectedImage: UIImage(named: "Search_fill"))
        playVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Play"), selectedImage: UIImage(named: "Play_fill"))
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal), tag: 2)
        favouriteVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Favorite"), selectedImage: UIImage(named: "Favorite_fill"))
        personVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Profile"), selectedImage: UIImage(named: "Profile_fill"))
                
        let searchNC = UINavigationController(rootViewController: searchVC)
        let playNC = UINavigationController(rootViewController: playVC)
        let homeNC = UINavigationController(rootViewController: homeVC)
        let favouriteNC = UINavigationController(rootViewController: favouriteVC)
        let personNC = UINavigationController(rootViewController: personVC)
        
        let tabBarList = [searchNC, playNC, homeNC, favouriteNC, personNC]
        
        viewControllers = tabBarList
        
        for tab in tabBarList {
            tab.tabBarItem.imageInsets = UIEdgeInsets(top: 13, left: 0, bottom: -13, right: 0)
        }
        
    }

    private func setupTabBar() {
        tabBar.clipsToBounds = true
        tabBar.tintColor = Theme.violetColor
        tabBar.unselectedItemTintColor = Theme.grayColor
        tabBar.isTranslucent = false
        tabBar.backgroundColor = Theme.appColor
//        tabBar.selectedItem?.imageInsets = .init(top: 10, left: 0, bottom: -10, right: 0)
    }
    
    
    
    
}
