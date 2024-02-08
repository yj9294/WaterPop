//
//  TimeView.swift
//  WaterPop
//
//  Created by yangjian on 2024/2/1.
//

import UIKit

class TimeView: UIView {
    
    private let hours: [Int] = Array(0...23)
    private let minutes: [Int] = Array(0...59)
    private var hour: Int = 0
    private var minute: Int = 0
    private var completion: ((Int, Int)->Void)? = nil
    
    private lazy var hourCollection = {
        let hourCollection = UIPickerView()
        hourCollection.delegate = self
        hourCollection.dataSource = self
        return hourCollection
    }()
    
    init(hour: Int, minute: Int, completion: ((Int, Int)->Void)? = nil) {
        super.init(frame: .zero)
        self.hour = hour
        self.minute = minute
        self.completion = completion
        setupUI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.hourCollection.selectRow(hour, inComponent: 0, animated: false)
            self.hourCollection.selectRow(minute, inComponent: 1, animated: false)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = .black.withAlphaComponent(0.4)
        
        let contentView = UIView()
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-35)
            make.width.equalTo(contentView.snp.height).multipliedBy(305.0 / 292.0)
        }
        
        let background = UIImageView(image: UIImage(named: "timer_selected"))
        background.contentMode = .scaleToFill
        contentView.addSubview(background)
        background.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let closeButton = UIButton()
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        closeButton.setImage(UIImage(named: "time_close"), for: .normal)
        contentView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
        }
        
        contentView.addSubview(hourCollection)
        hourCollection.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(136)
            make.height.equalTo(180)
        }
        
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "goal_button_bg"), for: .normal)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(165)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    @objc func closeAction() {
        self.removeFromSuperview()
    }
    
    @objc func saveAction() {
        completion?(hour, minute)
        self.removeFromSuperview()
    }
    
}

extension TimeView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 55
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component == 0 ? hours.count : minutes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let view = view as? UILabel {
            let string = component == 0 ? hours[row] : minutes[row]
            view.text = String(format: "%02d", string)
            return view
        }
        
        let label = UILabel()
        label.textColor = UIColor(hex: 0x031921)
        label.font = .systemFont(ofSize: 35)
        label.textAlignment = .center
        let string = component == 0 ? hours[row] : minutes[row]
        label.text = String(format: "%02d", string)
        label.frame = CGRect(x: 0, y: 0, width: 55, height: 60)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            hour = row
        } else {
            minute = row
        }
    }
}
