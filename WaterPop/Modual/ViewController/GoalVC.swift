//
//  GoalVC.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/30.
//

import UIKit

class GoalVC: BaseVC {
    
    private var goal = CacheUtil.shared.goal
    
    private lazy var goalLabel = {
        let goalLabel = UILabel()
        goalLabel.textColor = UIColor(hex: 0x031921)
        goalLabel.font = .systemFont(ofSize: 25)
        goalLabel.textAlignment = .center
        return goalLabel
    }()
    
    private lazy var sliderView: UISlider = {
        let progressView = UISlider()
        progressView.maximumTrackTintColor = UIColor(hex: 0xD2DDED)
        progressView.tintColor = .white
        progressView.layer.cornerRadius = 5
        progressView.minimumValue = 100.0 / 4000.0
        progressView.layer.masksToBounds = true
        return progressView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = UIImageView(image: UIImage(named: "goal_title"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }

}

extension GoalVC {
    
    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = UIColor(hex: 0xF3F8FB)
        
        let contentView = UIView()
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        let backgroundView = UIImageView(image: UIImage(named: "goal_bg"))
        contentView.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        label.text = "Hello, please enter your goal here"
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(16)
        }
        
        let inputView = UIImageView(image: UIImage(named: "goal_input"))
        contentView.addSubview(inputView)
        inputView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(23)
            make.left.equalToSuperview().offset(16)
        }
        

        inputView.addSubview(goalLabel)
        goalLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        let progressView = UIView()
        contentView.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.height.equalTo(46)
            make.left.bottom.right.equalToSuperview()
        }
        
        let progressBg = UIImageView(image: UIImage(named: "goal_progress_bg"))
        progressBg.contentMode = .scaleAspectFill
        progressView.addSubview(progressBg)
        progressBg.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let minus = UIButton()
        minus.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        minus.setImage(UIImage(named: "goal_-"), for: .normal)
        progressView.addSubview(minus)
        minus.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        let plus = UIButton()
        plus.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        plus.setImage(UIImage(named: "goal_+"), for: .normal)
        progressView.addSubview(plus)
        plus.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
        
        progressView.addSubview(sliderView)
        sliderView.addTarget(self, action: #selector(progressChanged), for: .valueChanged)
        sliderView.snp.makeConstraints { make in
            make.left.equalTo(minus.snp.right).offset(16)
            make.right.equalTo(plus.snp.left).offset(-16)
            make.centerY.equalToSuperview()
        }
        
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "goal_button_bg"), for: .normal)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
        }
    }
    
    override func loadData() {
        super.loadData()
        sliderView.value = (Float(goal) / 4000.0) >= 1.0 ? 1.0 : (Float(goal) / 4000.0)
        goalLabel.text = "\(goal)ml"
    }
    
}

extension GoalVC {
    
    @objc func saveButtonTapped() {
        CacheUtil.shared.goal = goal
        navigationController?.popViewController(animated: true)
    }
    
    @objc func plusButtonTapped() {
        goal += 100
        if goal > 4000 {
            goal = 4000
        }
        loadData()
    }
    
    @objc func minusButtonTapped() {
        goal -= 100
        if goal < 100 {
            goal = 100
        }
        loadData()
    }
    
    @objc func progressChanged() {
        goal = Int(sliderView.value * 40) * 100
        loadData()
    }
}
