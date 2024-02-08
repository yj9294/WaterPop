//
//  CacheUtil.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/29.
//

import Foundation
import Foundation

class CacheUtil {
    static let  shared = CacheUtil()
    
    @FileHelper(.drinks, default: [])
    var drinks: [WaterModel]
    
    @FileHelper(.goal, default: 2000)
    var goal: Int
    
    @FileHelper(.reminders, default: ReminderModel.models)
    var reminders: [ReminderModel]
    
    @FileHelper(.week, default: false)
    var weekMode: Bool
}
