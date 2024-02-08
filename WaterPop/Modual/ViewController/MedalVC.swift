//
//  MedalVC.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/30.
//

import UIKit

class MedalVC: BaseVC {
    
    private lazy var keepDayCollection = {
        let layout = UICollectionViewFlowLayout()
        let keepDayCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        keepDayCollection.dataSource = self
        keepDayCollection.isScrollEnabled = false
        keepDayCollection.backgroundColor = .clear
        keepDayCollection.register(MedalCell.classForCoder(), forCellWithReuseIdentifier: "MedalCell")
        keepDayCollection.delegate = self
        return keepDayCollection
    }()

    private lazy var keepGoalCollection = {
        let layout = UICollectionViewFlowLayout()
        let keepDayCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        keepDayCollection.dataSource = self
        keepDayCollection.isScrollEnabled = false
        keepDayCollection.backgroundColor = .clear
        keepDayCollection.register(MedalCell.classForCoder(), forCellWithReuseIdentifier: "MedalCell")
        keepDayCollection.delegate = self
        return keepDayCollection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = UIImageView(image: UIImage(named: "medal_title"))
        loadData()
    }

}

extension MedalVC {
    
    override func setupUI() {
        super.setupUI()
        let imageView = UIImageView(image: UIImage(named: "home_bg"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let keepDayView = UIView()
        view.addSubview(keepDayView)
        keepDayView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(268)
        }
        
        let keepBackground = UIImageView(image: UIImage(named: "medal_ground"))
        keepBackground.contentMode = .scaleAspectFill
        keepDayView.addSubview(keepBackground)
        keepBackground.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let keepDayLabel = UILabel()
        keepDayLabel.textColor = .black
        keepDayLabel.font = .systemFont(ofSize: 15, weight: .medium)
        keepDayLabel.text = "Continuously drinking water"
        keepDayView.addSubview(keepDayLabel)
        keepDayLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(26)
        }
        

        keepDayView.addSubview(keepDayCollection)
        keepDayCollection.snp.makeConstraints { make in
            make.top.equalTo(keepDayLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(176)
        }
        
        let keepGoalView = UIView()
        view.addSubview(keepGoalView)
        keepGoalView.snp.makeConstraints { make in
            make.top.equalTo(keepDayView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(268)
        }
        
        let keepBackground1 = UIImageView(image: UIImage(named: "medal_ground_1"))
        keepBackground1.contentMode = .scaleAspectFill
        keepGoalView.addSubview(keepBackground1)
        keepBackground1.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let keepGoalLabel = UILabel()
        keepGoalLabel.textColor = .black
        keepGoalLabel.font = .systemFont(ofSize: 15, weight: .medium)
        keepGoalLabel.text = "Drinking Water Achievement"
        keepGoalView.addSubview(keepGoalLabel)
        keepGoalLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(26)
        }
        

        keepGoalView.addSubview(keepGoalCollection)
        keepGoalCollection.snp.makeConstraints { make in
            make.top.equalTo(keepGoalLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(186)
        }
    }
    
    override func loadData() {
        super.loadData()
        keepDayCollection.reloadData()
        keepGoalCollection.reloadData()
    }
    
}

extension MedalVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedalCell", for: indexPath)
        if let cell = cell as? MedalCell {
            cell.icon = collectionView == keepDayCollection ? MedalIKeepDayItem.allCases[indexPath.row].icon : MedalIKeepGoalItem.allCases[indexPath.row].icon
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView == keepDayCollection ? CGSize(width: 84, height: 74) : CGSize(width: 84, height: 85)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionView == keepDayCollection ? 28 : 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        25.0
    }
}
