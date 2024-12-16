//
//  TabBarController.swift
//  AdventureDoToList
//
//  Created by Huy on 12/12/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        navigationItem.hidesBackButton = true

        super.viewDidLoad()

        self.tabBar.tintColor = UIColor.systemPink               //
        self.tabBar.unselectedItemTintColor = UIColor.gray
        self.tabBar.backgroundColor = .white
        
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12,weight: .black)], for: .normal)
        
        let homeVC = HomeViewController()
        

        let nav1 = UINavigationController(rootViewController: homeVC)
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
      
        setViewControllers([nav1], animated:false)    }
    


}
