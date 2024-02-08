//
//  HistoryDateCell.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/31.
//

import UIKit

class HistoryDateCell: UITableViewCell {
    
    private lazy var collectionView: UICollectionView  = {
        let flowLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.isScrollEnabled = false
        collection.register(HistoryCell.classForCoder(), forCellWithReuseIdentifier: "HistoryCell")
        return collection
    }()
    
    var datasource: [WaterModel] = [] {
        didSet {
            setupUI()
            collectionView.reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        selectionStyle = .none
        contentView.subviews.forEach({$0.removeFromSuperview()})
        
        let centerView = UIView()
        centerView.backgroundColor = .white
        centerView.layer.cornerRadius = 8
        centerView.layer.masksToBounds = true
        contentView.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
        let dateView = UIImageView(image: UIImage(named: "history_date"))
        centerView.addSubview(dateView)
        dateView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.left.equalToSuperview().offset(16)
        }
        
        let dateLabel = UILabel()
        dateLabel.textColor = UIColor(hex: 0x0F74F6)
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.text = datasource.first?.date.date ?? ""
        centerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dateView)
            make.left.equalTo(dateView.snp.right).offset(8)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(hex: 0xCCE0E8)
        centerView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(12.5)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(1)
        }
        
        centerView.addSubview(collectionView)
        let count = (datasource.count + 1) / 2
        let height = count * 36 + (12 * ((count - 1) < 0 ? 0 : (count - 1)))
        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(height)
            make.bottom.equalToSuperview()
        }
        
    }
}

extension HistoryDateCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCell", for: indexPath)
        if let cell = cell as? HistoryCell {
            cell.model = datasource[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 32 - 40 - 10) / 2.0 - 1
        let height = 36.0
        return CGSize(width: width, height: height)
    }
}


class HistoryCell: UICollectionViewCell {
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .black
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
    
    var model: WaterModel? = nil {
        didSet {
            guard let model = model else {return}
            icon.image = UIImage(named: model.item.icon)
            title.text = "\(model.item.title) \(model.ml)ml"
        }
    }
    
    func setupUI() {
        self.backgroundColor = UIColor(hex: 0xE1F7FF)
        self.layer.cornerRadius = 18
        self.layer.masksToBounds = true
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(32)
        }
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(4)
        }
    }
    
}
