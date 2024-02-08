//
//  HomeData.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/30.
//

import UIKit

enum HomeItem: String, CaseIterable {
    case drink, charts, medal, setting
    
    var icon: String {
        return "home_\(self.rawValue)"
    }
    
    var selectedIcon: String {
        return "\(icon)_1"
    }
    
    var vc: BaseVC {
        switch self {
        case .drink:
            return DrinkVC()
        case .charts:
            return ChartsVC()
        case .medal:
            return MedalVC()
        case .setting:
            return SettingVC()
        }
    }
}
