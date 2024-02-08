//
//  MedalCell.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/31.
//

import UIKit

class MedalCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var icon: String = "" {
        didSet {
            imageView.image = UIImage(named: icon)
        }
    }
    
    func setupUI() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
