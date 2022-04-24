//
//  NavigationViewController.swift
//  Traveler
//
//  Created by Samim Hakimi on 4/13/22.
//

import UIKit

class NavigationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        
        let home = UINavigationController(rootViewController: HomeViewController())
        
        //home.title = "Home"
    
        let add = UINavigationController(rootViewController:AddViewController())
        //add.title = "Add"
        let list = UINavigationController(rootViewController:ListViewController())
        //list.title = "List"
        
        
        let tabVC = UITabBarController()
        tabVC.setViewControllers([home, add, list], animated: true)
        tabVC.modalPresentationStyle = .fullScreen
        tabVC.tabBar.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        guard let items = tabVC.tabBar.items else {
            return
        }
        tabVC.tabBar.tintColor = UIColor(red: 68/255, green: 179/255, blue: 229/255, alpha: 1.0)
        tabVC.tabBar.itemPositioning = .centered
        tabVC.tabBarItem.imageInsets = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
        tabVC.selectedIndex = 2
        let images = ["house.fill", "tshirt.fill", "list.bullet"]
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
            
        }
        
        present(tabVC, animated: false)
    }
    

   

}
