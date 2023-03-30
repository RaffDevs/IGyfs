//
//  TabBarControllerViewController.swift
//  IGyfs
//
//  Created by Rafael Veronez Dias on 13/03/23.
//

import UIKit

class TabBarControllerViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = .black
        setupTabBarController()
        
    }
    
    private func setupTabBarController() {
        let giffViewController = GiffViewController()
        let favoriteGiffViewController = FavoriteGiffViewController()
        
        giffViewController.tabBarItem = UITabBarItem(title: "Gifs", image: UIImage(systemName: "face.smiling.inverse"), tag: 0)
        favoriteGiffViewController.tabBarItem = UITabBarItem(title: "Favoritos", image: UIImage(systemName: "star.fill"), tag: 1)
        
        self.setViewControllers([giffViewController, favoriteGiffViewController], animated: true)
    }
    

}
