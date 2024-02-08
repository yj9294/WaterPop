//
//  ChartsRightCell.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/31.
//

import Foundation
import UIKit

class ChartsRightCell: UICollectionViewCell {
    
    private lazy var gridentLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        // 定义渐变颜色
        gradientLayer.colors = [UIColor(hex: 0x00B2F6).cgColor, UIColor(hex: 0xC1E7FF).cgColor]
        // 定义渐变方向
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradientLayer
    }()
    
    private lazy var gradientView = {
        let view = UIView()
        view.layer.addSublayer(gridentLayer)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: ChartsModel? = nil {
        didSet {
            setupUI()
        }
    }
    
    func setupUI() {
        
        subviews.forEach({$0.removeFromSuperview()})
        
        guard let  model = model else { return }
        
        let progressView = UIView()
        addSubview(progressView)
        progressView.layer.cornerRadius = 2
        progressView.layer.masksToBounds = true
        progressView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44 * 6)
        }
        
        let grayView = UIView()
        grayView.backgroundColor = UIColor(hex: 0xEBF2F5)
        progressView.addSubview(grayView)
        grayView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44 * 6 * (1 - model.progress))
        }
        
        progressView.addSubview(gradientView)
        gradientView.layer.addSublayer(gridentLayer)
        gradientView.snp.makeConstraints { make in
            make.top.equalTo(grayView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        
        let unitLabel = UILabel()
        unitLabel.textColor = UIColor(hex: 0x031921)
        unitLabel.font = .systemFont(ofSize: 10, weight: .medium)
        unitLabel.text = model.unit
        unitLabel.textAlignment = .center
        addSubview(unitLabel)
        unitLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(10)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gridentLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 44 * 6 * (model?.progress ?? 0))
    }
}
