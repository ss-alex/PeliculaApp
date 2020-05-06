//
//  PATabBarController.swift
//  PeliculaApp
//
//  Created by Alexey Kirpichnikov on 2020/4/16.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

class PATabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = Colors.customRed.color
        viewControllers = [createSearchNC(),createFavoritesNC()]
    }
    
    func createSearchNC () -> UINavigationController {
        let searchVC          = SearchVC()
        searchVC.title        = "Search"
        searchVC.tabBarItem   = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC          = FavoritesListVC()
        favoritesListVC.title        = "Favorites"
        favoritesListVC.tabBarItem   = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesListVC)
    }
    
}
