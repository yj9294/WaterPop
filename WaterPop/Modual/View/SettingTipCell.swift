//
//  SettingTipCell.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/31.
//

import UIKit

class SettingTipCell: UITableViewCell {

    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item: SettingTipItem = .tip1 {
        didSet {
            icon.image = UIImage(named: item.icon)
            title.text = item.title
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
            make.height.equalTo(104)
        }
        
        centerView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        centerView.addSubview(title)
        title.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
    }
}
