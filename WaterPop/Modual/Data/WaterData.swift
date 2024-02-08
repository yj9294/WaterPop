//
//  WaterModel.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/30.
//

import Foundation

struct WaterModel: Codable, Hashable, Equatable {
    var id: String = UUID().uuidString
    var date: Date
    var item: WaterItem // 列别
    var name: String
    var ml: Int // 毫升
    var goal: Int
}

enum WaterItem: String, Codable, CaseIterable {
    case water, drinks, coffee, tea, milk, custom
    var title: String{
        return self.rawValue.capitalized
    }
    var icon: String {
        return "water_" + self.rawValue
    }
}
