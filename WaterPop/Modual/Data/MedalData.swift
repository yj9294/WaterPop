//
//  MedalData.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/31.
//

import Foundation

enum MedalIKeepDayItem: String, CaseIterable {
    case th_days, week, month, th_months, six_months, year
    var icon: String {
        let drinks = CacheUtil.shared.drinks
        switch self {
        case .th_days:
            return hasConsecutiveDates(drinks, 3) ? enableIcon : disableIcon
        case .week:
            return hasConsecutiveDates(drinks, 7) ? enableIcon : disableIcon
        case .month:
            return hasConsecutiveDates(drinks, 30) ? enableIcon : disableIcon
        case .th_months:
            return hasConsecutiveDates(drinks, 90) ? enableIcon : disableIcon
        case .six_months:
            return hasConsecutiveDates(drinks, 180) ? enableIcon : disableIcon
        case .year:
            return hasConsecutiveDates(drinks, 365) ? enableIcon : disableIcon
        }
    }
    
    var enableIcon: String {
        return "medal_\(self.rawValue)"
    }
    
    var disableIcon: String {
        return "medal_\(self.rawValue)_1"
    }
}

func hasConsecutiveDates(_ drinks: [WaterModel], _ n: Int) -> Bool {
    
    let dateModels: [[WaterModel]] =  drinks.reduce([[]]) { partialResult, model in
        var result = partialResult
        if var p = result.first {
            if let f = p.first, f.date.date == model.date.date  {
                p.insert(model, at: 0)
                result[0] = p
                return result
            }
            result.insert([model], at: 0)
            return result
        }
        result = [[model]]
        return result
    }
    
    let dates = dateModels.compactMap{$0.first}.map { $0.date }
    
    guard n > 1, dates.count >= n else {
        // 如果 n 不大于 1 或者日期数组长度小于 n，则直接返回 false
        return false
    }

    for i in 0...(dates.count - n) {
        let startDate = dates[i]
        let endDate = dates[i + n - 1]

        // 计算当前日期范围内的日期数量
        let currentDates = dates.filter { $0 >= startDate && $0 <= endDate }

        if currentDates.count == n {
            // 找到了 n 个连续的日期
            return true
        }
    }

    // 未找到 n 个连续的日期
    return false
}

enum MedalIKeepGoalItem: String, CaseIterable {
    case one, ten, th, houndred, tw_houndred, th_houndred
    var icon: String {
        let drinks = CacheUtil.shared.drinks
        switch self {
        case .one:
            return hasKeepGoal(drinks, 1) ? enableIcon : disableIcon
        case .ten:
            return hasKeepGoal(drinks, 10) ? enableIcon : disableIcon
        case .th:
            return hasKeepGoal(drinks, 30) ? enableIcon : disableIcon
        case .houndred:
            return hasKeepGoal(drinks, 100) ? enableIcon : disableIcon
        case .tw_houndred:
            return hasKeepGoal(drinks, 200) ? enableIcon : disableIcon
        case .th_houndred:
            return hasKeepGoal(drinks, 300) ? enableIcon : disableIcon
        }
    }
    
    var enableIcon: String {
        return "medal_\(self.rawValue)"
    }
    
    var disableIcon: String {
        return "medal_\(self.rawValue)_1"
    }
}

struct MedalGoalModel {
    var ml: Int
    var goal: Int
}


func hasKeepGoal(_ models: [WaterModel], _ n: Int) -> Bool {
    let dateModels: [[WaterModel]] =  models.reduce([[]]) { partialResult, model in
        var result = partialResult
        if var p = result.first {
            if let f = p.first, f.date.date == model.date.date  {
                p.insert(model, at: 0)
                result[0] = p
                return result
            }
            result.insert([model], at: 0)
            return result
        }
        result = [[model]]
        return result
    }
    
    let goals = dateModels.map { dateModels in
        let ml = dateModels.map({$0.ml}).reduce(0, +)
        let goal = dateModels.first?.goal ?? 2000
        return MedalGoalModel(ml: ml, goal: goal)
    }
    
    return goals.filter({$0.ml >= $0.goal}).count >= n
}
