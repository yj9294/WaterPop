//
//  SettingCell.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/31.
//

import UIKit

class SettingCell: UITableViewCell {
    
    private lazy var icon = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var title = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x040404)
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item: SettingItem = .reminder {
        didSet {
            title.text = item.title
            icon.image = UIImage(named: item.icon)
        }
    }
    
    func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.backgroundView?.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        let centerView = UIView()
        centerView.backgroundColor = .white
        centerView.layer.cornerRadius = 8
        centerView.layer.masksToBounds = true
        contentView.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(56)
        }
        
        centerView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        
        centerView.addSubview(title)
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(10)
        }
        
        let arrow = UIImageView(image: UIImage(named: "setting_arrow"))
        centerView.addSubview(arrow)
        arrow.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
        }
    }

}
