//
//  SettingVC.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/30.
//

import UIKit

class SettingVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = UIImageView(image: UIImage(named: "setting_title"))
    }
    
}

extension SettingVC {
    
    override func setupUI() {
        super.setupUI()
        let imageView = UIImageView(image: UIImage(named: "home_bg"))
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingCell.classForCoder(), forCellReuseIdentifier: "SettingCell")
        tableView.register(SettingTipCell.classForCoder(), forCellReuseIdentifier: "SettingTipCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    override func loadData() {
        super.loadData()
    }
}


extension SettingVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? SettingItem.allCases.count : SettingTipItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
            if let cell = cell as? SettingCell {
                cell.item = SettingItem.allCases[indexPath.row]
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTipCell", for: indexPath)
            if let cell = cell as? SettingTipCell {
                cell.item = SettingTipItem.allCases[indexPath.row]
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch SettingItem.allCases[indexPath.row] {
            case .reminder:
                let vc = ReminderVC()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            case .privacy:
                let vc = PrivacyVC()
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            case .rate:
                if let url = URL(string: "https://itunes.apple.com/cn/app/id6477567281"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        } else {
            let item = SettingTipItem.allCases[indexPath.row]
            let detailVC = TipDetailVC(item: item)
            detailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
