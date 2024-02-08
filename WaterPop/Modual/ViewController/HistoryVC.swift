//
//  HistoryVC.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/31.
//

import Foundation
import UIKit


class HistoryVC: BaseVC {
    
    private var drinks: [WaterModel] { CacheUtil.shared.drinks }
    
    // 根据时间分组
    private var datasource: [[WaterModel]] {
        return drinks.reduce([]) { (result, item) -> [[WaterModel]] in
            var result = result
            if result.count == 0 {
                result.append([item])
            } else {
                if var arr = result.last, let lasItem = arr.last, lasItem.date.date == item.date.date  {
                    arr.append(item)
                    result[result.count - 1] = arr
                } else {
                    result.append([item])
                }
            }
           return result
        }.reversed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
        navigationItem.titleView = UIImageView(image: UIImage(named: "history_title"))
    }
    
}

extension HistoryVC {
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = UIColor(hex: 0xEBF6F8)
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hex: 0xEBF6F8)
        tableView.dataSource = self
        tableView.register(HistoryDateCell.classForCoder(), forCellReuseIdentifier: "HistoryDateCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    override func loadData() {
        super.loadData()
    }
    
}

extension HistoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryDateCell", for: indexPath)
        if let cell = cell as? HistoryDateCell {
            cell.datasource = datasource[indexPath.row]
        }
        return cell
    }
    
}
