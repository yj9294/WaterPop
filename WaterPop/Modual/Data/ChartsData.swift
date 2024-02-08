//
//  ChartsData.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/31.
//

import Foundation

enum ChartsItem: String, CaseIterable {
    case day, week, month, year
    var title: String {
        return self.rawValue.capitalized
    }
}

struct ChartsModel {
    var id: String = UUID().uuidString
    var progress: CGFloat
    var ml: Int
    var unit: String // 描述 类似 9:00 或者 Mon  或者03/01 或者 Jan
}
