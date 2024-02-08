//
//  ChartLeftCell.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/31.
//

import Foundation
import UIKit

class ChartLeftCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x06ABE9)
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: String = "" {
        didSet {
            setupUI()
        }
    }
    
    func setupUI() {
        selectionStyle = .none
        backgroundView?.backgroundColor = .clear
        backgroundColor = .clear
        titleLabel.text = title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-2)
        }
    }
}
