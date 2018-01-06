//
//  HomeController.swift
//  
//
//  Created by Simon BRAMI on 13/12/2017.
//

import UIKit

class HomeController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarItems = tabBar.items! as [UITabBarItem]
        tabBarItems[0].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        tabBarItems[1].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        tabBarItems[2].imageInsets = UIEdgeInsetsMake(6,0,-6,0)
        tabBarItems[3].imageInsets = UIEdgeInsetsMake(6,0,-6,0)


        self.selectedIndex = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
