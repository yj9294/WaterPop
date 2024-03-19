//
//  ReminderVC.swift
//  WaterPop
//
//  Created by yangjian on 2024/2/1.
//

import UIKit
import GADUtil

class ReminderVC: BaseVC {
    
    private var datasource = CacheUtil.shared.reminders
    private var weekMode = CacheUtil.shared.weekMode
    
    private lazy var reminderView = {
        let reminderView = UITableView(frame: .zero, style: .plain)
        reminderView.delegate = self
        reminderView.dataSource = self
        reminderView.backgroundColor = .clear
        reminderView.separatorStyle = .none
        reminderView.showsVerticalScrollIndicator = false
        reminderView.showsHorizontalScrollIndicator = false
        reminderView.register(ReminderCell.classForCoder(), forCellReuseIdentifier: "ReminderCell")
        return reminderView
    }()
    
    private lazy var weekButton = {
        let weekButton = UIButton()
        weekButton.setImage(UIImage(named: "week_off"), for: .normal)
        weekButton.setImage((UIImage(named: "week_on")), for: .selected)
        weekButton.addTarget(self, action: #selector(updateWeekMode), for: .touchUpInside)
        weekButton.isSelected = weekMode
        return weekButton
    }()
    
    private var willAppear = false
    
    @FileHelper(.impressReminder, default: Date().addingTimeInterval(-11))
    private var impressDate: Date
    private lazy var adView: GADNativeView = {
        if UIScreen.main.bounds.width > 375 {
            let adView = GADNativeView(.big)
            return adView
        }
        let adView = GADNativeView(.small)
        return adView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(nativeADLoad), name: .nativeUpdate, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = UIImageView(image: UIImage(named: "reminder_title"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add_new"), style: .plain, target: self, action: #selector(newReminder))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
        willAppear = true
        GADUtil.share.disappear(.native)
        GADUtil.share.load(.native)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        willAppear = false
        GADUtil.share.disappear(.native)
    }
    
    @objc func newReminder() {
        if let scene = UIApplication.shared.connectedScenes.filter({$0 is UIWindowScene}).first as? UIWindowScene, let window = scene.windows.first {
            let timerView = TimeView(hour: Date().hour, minute: Date().minute) { hour, minute in
                let model = ReminderModel(hour: hour, minute: minute)
                CacheUtil.shared.reminders.append(model)
                CacheUtil.shared.reminders.sort(by: {$0.title < $1.title})
                NotificationUtil.shared.appendReminder(model)
                self.loadData()
            }
            window.addSubview(timerView)
            timerView.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
            }
        }
    }
    
    @objc func updateWeekMode() {
        weekButton.isSelected = !weekButton.isSelected
        weekMode.toggle()
        CacheUtil.shared.weekMode = weekMode
        loadData()
    }

    @objc func nativeADLoad(noti: Notification) {
        if let ad = noti.object as? GADNativeModel {
            if willAppear {
                if  Date().timeIntervalSince1970 - impressDate.timeIntervalSince1970 > 10 {
                    adView.nativeAd = ad.nativeAd
                    impressDate = Date()
                    return
                } else {
                    NSLog("[ad] (native) 10显示间隔 reminder")
                }
            }
        }
        adView.nativeAd = nil
    }
}

extension ReminderVC {
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = UIColor(hex: 0xEBF6F8)
        
        
        let weekView = UIView()
        view.addSubview(weekView)
        weekView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(117)
        }
        
        let backgroundView = UIImageView(image: UIImage(named: "week_bg"))
        backgroundView.contentMode = .scaleAspectFill
        weekView.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let weekTitle = UILabel()
        weekTitle.textColor = .white
        weekTitle.font = .systemFont(ofSize: 19)
        weekTitle.text = "Weekend Mode"
        weekView.addSubview(weekTitle)
        weekTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(14)
        }

        weekView.addSubview(weekButton)
        weekButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.right.equalToSuperview().offset(-12)
        }
        
        let weekTipLabel = UILabel()
        weekTipLabel.textColor = .white.withAlphaComponent(0.7)
        weekTipLabel.font = .systemFont(ofSize: 14)
        weekTipLabel.numberOfLines = 0
        weekTipLabel.text = "After opening, you won't receive any messages on weekends"
        weekView.addSubview(weekTipLabel)
        weekTipLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        let reminderTitle = UILabel()
        reminderTitle.textColor = .black
        reminderTitle.font = .systemFont(ofSize: 15)
        reminderTitle.text = "Reminder Time"
        view.addSubview(reminderTitle)
        reminderTitle.snp.makeConstraints { make in
            make.top.equalTo(weekView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(reminderView)
        reminderView.snp.makeConstraints { make in
            make.top.equalTo(reminderTitle.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        
        view.addSubview(adView)
        adView.snp.makeConstraints { make in
            make.top.equalTo(reminderView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(124)
            make.bottom.equalTo(view.snp.bottom).offset(-20)
        }
    }
    
    override func loadData() {
        super.loadData()
        datasource = CacheUtil.shared.reminders
        weekMode = CacheUtil.shared.weekMode
        datasource.forEach { model in
            NotificationUtil.shared.appendReminder(model)
        }
        weekButton.isSelected = weekMode
        reminderView.reloadData()
    }
}

extension ReminderVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath)
        if let cell = cell as? ReminderCell {
            cell.item = datasource[indexPath.section]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let model = datasource[indexPath.section]
            NotificationUtil.shared.deleteNotifications(model)
            CacheUtil.shared.reminders.remove(at: indexPath.section)
            loadData()
        }
    }
    
}
