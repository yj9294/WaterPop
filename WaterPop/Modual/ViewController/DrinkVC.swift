//
//  DrinkVC.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/30.
//

import UIKit

class DrinkVC: BaseVC {
    
    private var goal: Int { CacheUtil.shared.goal }
    private var drinks: [WaterModel] { CacheUtil.shared.drinks }
    private var total: Int { CacheUtil.shared.drinks.filter({$0.date.isToday}).map({$0.ml}).reduce(0, +) }
    
    private lazy var goalLabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x031921)
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var progressBackgroundView = {
        let progressBackgroundView = UIImageView(image: UIImage(named: "drink_progress_bg"))
        return progressBackgroundView
    }()
    
    private lazy var progressLabel = {
        let progressLabel = UILabel()
        progressLabel.textColor = UIColor(hex: 0x031921)
        progressLabel.font = .systemFont(ofSize: 34)
        progressLabel.textAlignment = .center
        return progressLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = UIImageView(image: UIImage(named: "drink_title"))
        startProgressView(progressView: progressBackgroundView)
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopProgressView(progressView: progressBackgroundView)
    }

}

extension DrinkVC {
    override func setupUI() {
        super.setupUI()
        let backgroundView = UIImageView(image: UIImage(named: "home_bg"))
        backgroundView.contentMode = .scaleAspectFill
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let buttonView = UIView()
        view.addSubview(buttonView)
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(40)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        let goalView = UIView()
        buttonView.addSubview(goalView)
        goalView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
        }
        
        let goalBackgroundView = UIImageView(image: UIImage(named: "drink_button_bg"))
        goalBackgroundView.contentMode = .scaleAspectFill
        goalView.addSubview(goalBackgroundView)
        goalBackgroundView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let recordView = UIView()
        buttonView.addSubview(recordView)
        recordView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(goalView.snp.right).offset(20)
            make.width.equalTo(goalView.snp.width)
        }
        
        
        let recordBackgroundView = UIImageView(image: UIImage(named: "drink_button_bg"))
        recordBackgroundView.contentMode = .scaleAspectFill
        recordView.addSubview(recordBackgroundView)
        recordBackgroundView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let goalIcon = UIImageView(image: UIImage(named: "drink_goal"))
        goalView.addSubview(goalIcon)
        goalIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.left.equalToSuperview().offset(16)
        }
        
        goalView.addSubview(goalLabel)
        goalLabel.snp.makeConstraints { make in
            make.top.equalTo(goalIcon.snp.bottom).offset(22)
            make.left.equalToSuperview().offset(16)
        }
        
        let goalButton = UIButton()
        goalButton.addTarget(self, action: #selector(gotoGoalVC), for: .touchUpInside)
        goalView.addSubview(goalButton)
        goalButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }

        
        let addIcon = UIImageView(image: UIImage(named: "drink_add"))
        recordView.addSubview(addIcon)
        addIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.left.equalToSuperview().offset(16)
        }
        
        let recordLabel = UILabel()
        recordLabel.textColor = UIColor(hex: 0x031921)
        recordLabel.font = .systemFont(ofSize: 20)
        recordLabel.text = "Add Record"
        recordView.addSubview(recordLabel)
        recordLabel.snp.makeConstraints { make in
            make.top.equalTo(addIcon.snp.bottom).offset(22)
            make.left.equalToSuperview().offset(16)
        }
        
        let recordButton = UIButton()
        recordButton.addTarget(self, action: #selector(gotoRecordVC), for: .touchUpInside)
        recordView.addSubview(recordButton)
        recordButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let progressView = UIView()
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonView.snp.bottom).offset(46)
        }
        
        progressView.addSubview(progressBackgroundView)
        progressBackgroundView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        progressView.addSubview(progressLabel)
        progressLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func startProgressView(progressView: UIView) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2.0
        animation.duration = 2
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        progressView.layer.add(animation, forKey: "roation")
    }
    
    func stopProgressView(progressView: UIView) {
        progressView.layer.removeAllAnimations()
    }
}

extension DrinkVC {
    
    override func loadData() {
        super.loadData()
        goalLabel.text = "\(goal)ml"
        let progress = Double(total) / Double(goal)
        progressLabel.text = "\(Int(progress * 100))%"
    }
    
    @objc func gotoRecordVC() {
        let vc = WaterVC()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func gotoGoalVC() {
        let vc = GoalVC()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
