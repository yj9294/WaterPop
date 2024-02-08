//
//  WaterVC.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/30.
//

import UIKit

class WaterVC: BaseVC {
    
    private var item = WaterItem.water {
        didSet {
            loadData()
        }
    }
    
    private var name: String {
        if item == .custom {
            return titleLabel.text ?? ""
        } else {
            return item.title
        }
    }
    
    private var ml: Int {
        return Int(mlTextField.text ?? "0") ?? 0
    }

    private lazy var titleLabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 29)
        return titleLabel
    }()
    
    private lazy var titleTextField = {
        let titleTextField = UITextField()
        titleTextField.textColor = .white
        titleTextField.textAlignment = .center
        titleTextField.font = .systemFont(ofSize: 29)
        titleTextField.delegate = self
        return titleTextField
    }()
    
    private lazy var mlTextField = {
        let mlTextField = UITextField()
        mlTextField.textColor = UIColor(hex: 0x031921)
        mlTextField.font = .systemFont(ofSize: 25)
        mlTextField.textAlignment = .right
        mlTextField.delegate = self
        return mlTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = UIImageView(image: UIImage(named: "water_title"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }

}

extension WaterVC {
    
    override func setupUI() {
        super.setupUI()
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hiddenKeyboard)))
        view.backgroundColor = UIColor(hex: 0xEBF6F8)
        
        let topView = UIView()
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        let topBgView = UIImageView(image: UIImage(named: "water_bg"))
        topView.addSubview(topBgView)
        topBgView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        

        topView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
            make.width.equalTo(178)
        }
        
        topView.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
        }
        
        let inputView = UIImageView(image: UIImage(named: "goal_input"))
        topView.addSubview(inputView)
        inputView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        let mlView = UIView()
        topView.addSubview(mlView)
        mlView.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(inputView)
        }

        mlView.addSubview(mlTextField)
        mlTextField.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
        }
        
        let mlLabel = UILabel()
        mlLabel.textColor = UIColor(hex: 0x031921)
        mlLabel.font = .systemFont(ofSize: 25)
        mlLabel.textAlignment = .left
        mlLabel.text = "ml"
        mlView.addSubview(mlLabel)
        mlLabel.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(mlTextField.snp.right)
        }
        
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsets(top: 14, left: 25, bottom: 14, right: 25)
        collectionView.layer.cornerRadius = 8
        collectionView.layer.masksToBounds = true
        collectionView.layer.borderColor = UIColor(hex: 0x06ABE9).cgColor
        collectionView.layer.borderWidth = 1
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(hex:0xE1F7FF)
        collectionView.register(WaterCell.classForCoder(), forCellWithReuseIdentifier: "WaterCell")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(330)
        }
        
        
        let lineView = UIImageView(image: UIImage(named: "line"))
        lineView.isUserInteractionEnabled = false
        view.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(collectionView)
        }
        
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "goal_button_bg"), for: .normal)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
    }
 
    override func loadData() {
        super.loadData()
        titleLabel.text = item.title
        titleTextField.text = item.title
        mlTextField.text = "\(200)"
        
        titleLabel.isHidden = item == .custom
        titleTextField.isHidden = item != .custom
    }
}

extension WaterVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WaterItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaterCell", for: indexPath)
        if let cell = cell as? WaterCell {
            cell.item = WaterItem.allCases[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = WaterItem.allCases[indexPath.row]
        self.item = item
        loadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 90) / 2.0 - 1
        let height = (317 - 28) / 3.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
}

extension WaterVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func saveButtonTapped() {
        if ml == 0 || name.isEmpty {
            return
        }
        let goal = CacheUtil.shared.goal
        let model = WaterModel(date: Date(), item: item, name: name, ml: ml, goal: goal)
        CacheUtil.shared.drinks.insert(model, at: 0)
        navigationController?.popViewController(animated: true)
    }
}
