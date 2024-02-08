//
//  ReminderCell.swift
//  WaterPop
//
//  Created by yangjian on 2024/2/1.
//

import UIKit

class ReminderCell: UITableViewCell {
    
    private lazy var title = {
        let title = UILabel()
        title.textColor = UIColor(hex: 0x031921)
        title.font = .systemFont(ofSize: 20)
        return title
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item: ReminderModel? = nil {
        didSet {
            title.text = item?.title
        }
    }
    
    func setupUI() {
        selectionStyle = .none
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
    }
    
}
