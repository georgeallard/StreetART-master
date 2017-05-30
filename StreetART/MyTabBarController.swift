//
//  MyTabBarController.swift
//  StreetART
//
//  Created by George Allard on 30/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBar.barTintColor = .black
        
    }
}
