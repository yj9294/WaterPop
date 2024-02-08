//
//  HomeVC.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/29.
//

import UIKit
import AppTrackingTransparency

class HomeVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = HomeItem.allCases.map({setupChildVC(item: $0)})
        ATTrackingManager.requestTrackingAuthorization { _ in
        }
    }
    

    func setupChildVC(item: HomeItem) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: item.vc)
        navigation.tabBarItem.image = UIImage(named: item.icon)
        navigation.tabBarItem.selectedImage = UIImage(named: item.selectedIcon)
        return navigation
    }
}
