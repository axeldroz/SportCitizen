//
//  HomeController.swift
//  
//
//  Created by Simon BRAMI on 13/12/2017.
//

import UIKit

class HomeController: UITabBarController, UITabBarControllerDelegate {

    @IBOutlet weak var NavigationBar: UINavigationItem!

    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            tabBarController.title = "Challenges"
        }
        else if tabBarIndex == 1 {
            tabBarController.title = "Feed"
        }
        else if tabBarIndex == 2 {
            tabBarController.title = "Profile"
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let tabBarItems = tabBar.items! as [UITabBarItem]
        tabBarItems[0].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        tabBarItems[1].imageInsets = UIEdgeInsetsMake(6,0,-6,0)


        self.selectedIndex = 1
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
