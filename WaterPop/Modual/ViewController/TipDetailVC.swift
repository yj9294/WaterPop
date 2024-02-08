//
//  TipDetailVC.swift
//  WaterPop
//
//  Created by yangjian on 2024/2/1.
//

import UIKit

class TipDetailVC: BaseVC {
    
    init(item: SettingTipItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var item: SettingTipItem

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = UIImageView(image: UIImage(named: "detail_title"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }

}

extension TipDetailVC {
    
    override func setupUI() {
        
        view.backgroundColor = UIColor(hex: 0xEBF6F8)
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.left.right.bottom.equalToSuperview()
        }
        
        let titleLabel = UILabel()
        titleLabel.textColor  = UIColor(hex: 0x040404)
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.text = item.title
        titleLabel.numberOfLines = 0
        scrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(view.snp.width).offset(-40)
        }
        
        let descripLabel = UILabel()
        descripLabel.textColor = UIColor(hex: 0x040404)
        descripLabel.font = .systemFont(ofSize: 16)
        descripLabel.text = item.description
        descripLabel.numberOfLines = 0
        scrollView.addSubview(descripLabel)
        descripLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.right.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
