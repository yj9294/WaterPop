//
//  WaterCell.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/30.
//

import UIKit

class WaterCell: UICollectionViewCell {
    
    private lazy var icon = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var title = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x06ABE9)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item: WaterItem = .water {
        didSet {
            title.text = item.title
            icon.image = UIImage(named: item.icon)
        }
    }
    
    func setupUI() {
        
        let centerView = UIView()
        addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        centerView.addSubview(icon)
        icon.image = UIImage(named: item.icon)
        icon.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
        }
        
        centerView.addSubview(title)
        title.text = item.title
        title.snp.makeConstraints { make in
            make.top.equalTo(icon).offset(5)
            make.left.equalTo(icon.snp.right).offset(12)
        }
        
        let ml = UILabel()
        ml.text = "200ml"
        ml.textColor = UIColor(hex: 0x333333)
        ml.font = .systemFont(ofSize: 16)
        centerView.addSubview(ml)
        ml.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(4)
            make.left.equalTo(title)
            make.right.equalToSuperview()
        }
    }
}
