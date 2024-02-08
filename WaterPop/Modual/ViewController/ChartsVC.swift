//
//  ChartsVC.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/30.
//

import UIKit

class ChartsVC: BaseVC {
    
    private lazy var leftView = {
        let leftView = UITableView(frame: .zero, style: .plain)
        leftView.backgroundColor = UIColor(hex: 0xEBF2F5)
        leftView.dataSource = self
        leftView.delegate = self
        leftView.separatorColor = .none
        leftView.backgroundColor = .clear
        leftView.register(ChartLeftCell.classForCoder(), forCellReuseIdentifier: "ChartsLeftCell")
        return leftView
    }()
    
    private lazy var rightView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let rightView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        rightView.register(ChartsRightCell.classForCoder(), forCellWithReuseIdentifier: "ChartsRightCell")
        rightView.backgroundColor = .clear
        rightView.dataSource = self
        rightView.delegate = self
        return rightView
    }()
    
    let numbers = [3000, 2500, 2000, 1500, 1000, 500, 0]
    
    private var drinks: [WaterModel] { CacheUtil.shared.drinks }
    
    private var item: ChartsItem = .day {
        didSet {
            loadData()
        }
    }
    
    private var leftDatasource: [String] {
        if item == .year {
            return numbers.map {"\($0 * 30)"}
        }
        return numbers.map { "\($0)" }
    }
    
    private var bottomDataource: [String] {
        switch item {
        case .day:
            return ["06:00", "12:00", "18:00", "24:00"]
        case .week:
            return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        case .month:
            var days: [String] = []
            for index in 0..<30 {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd"
                let date = Date(timeIntervalSinceNow: TimeInterval(index * 24 * 60 * 60 * -1))
                let day = formatter.string(from: date)
                days.insert(day, at: 0)
            }
            return days
        case .year:
            var months: [String] = []
            for index in 0..<12 {
                let d = Calendar.current.date(byAdding: .month, value: -index, to: Date()) ?? Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM"
                let day = formatter.string(from: d)
                months.insert(day, at: 0)
            }
            return months
        }
    }
    
    private var rightDatasource: [ChartsModel] {
        var max: Int = numbers.max() ?? 1
        switch item {
        case .day:
            return bottomDataource.map({ time in
                let total = drinks.filter { model in
                    if let t = time.components(separatedBy: ":").first, let max = Int(t) {
                        let min = max - 6
                        if model.date.hour >= min, model.date.hour <= max {
                            return true
                        }
                    }
                    return false
                }.map({
                    $0.ml
                }).reduce(0, +)
                return ChartsModel(progress: Double(total)  / Double(max) , ml: total, unit: time)
            })
        case .week:
            return bottomDataource.map { weeks in
                // 当前搜索目的周几 需要从周日开始作为下标0开始的 所以 unit数组必须是7123456
                let week = bottomDataource.firstIndex(of: weeks) ?? 0
                
                // 当前日期 用于确定当前周
                let weekDay = Calendar.current.component(.weekday, from: Date())
                let firstCalendar = Calendar.current.date(byAdding: .day, value: 1-weekDay, to: Date()) ?? Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                // 目标日期
                let target = Calendar.current.date(byAdding: .day, value: week, to: firstCalendar) ?? Date()
                let targetString = dateFormatter.string(from: target)
                
                
                let total: Int = drinks.filter {$0.date.date == targetString}.map({ $0.ml}).reduce(0, +)
                return ChartsModel(progress: Double(total)  / Double(max), ml: total, unit: weeks)
            }
        case .month:
            return bottomDataource.reversed().map { date in
                let year = Calendar.current.component(.year, from: Date())
                
                let month = date.components(separatedBy: "/").first ?? "01"
                let day = date.components(separatedBy: "/").last ?? "01"
                
                let total = drinks.filter { $0.date.date == "\(year)-\(month)-\(day)"}.map({ $0.ml }).reduce(0, +)
                
                return ChartsModel(progress: Double(total)  / Double(max), ml: total, unit: date)
                
            }
        case .year:
            max *= 30
            return  bottomDataource.reversed().map { month in
                let total = drinks.filter { model in
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let date = formatter.date(from: model.date.date)
                    formatter.dateFormat = "MMM"
                    let m = formatter.string(from: date!)
                    return m == month
                }.map({ $0.ml }).reduce(0, +)
                return ChartsModel(progress: Double(total)  / Double(max), ml: total, unit: month)
            }
        }
    }
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = UIImageView(image: UIImage(named: "charts_title"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "charts_history")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(gotoHistory))
        loadData()
    }
    
    @objc func gotoHistory() {
        let vc = HistoryVC()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChartsVC {
    
    override func setupUI() {
        super.setupUI()
        
        let imageView = UIImageView(image: UIImage(named: "charts_bg"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let topView = UIView()
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(25)
            make.left.equalToSuperview().offset(68)
            make.right.equalToSuperview().offset(-68)
            make.height.equalTo(44)
        }
        
        let topBackground = UIImageView(image: UIImage(named: "charts_button"))
        topBackground.contentMode = .scaleAspectFill
        topView.addSubview(topBackground)
        topBackground.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: "charts_left"), for: .normal)
        leftButton.addTarget(self, action: #selector(lastAction), for: .touchUpInside)
        topView.addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(6)
            make.width.height.equalTo(40)
        }
        
        let rightButton = UIButton()
        rightButton.setImage(UIImage(named: "charts_right"), for: .normal)
        rightButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        topView.addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-6)
            make.width.height.equalTo(40)
        }
        
        topView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        let centerView = UIView()
        contentView.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-12)
            make.height.equalTo(289 + 24)
        }
        
        let contentBackgroundView = UIImageView(image: UIImage(named: "charts_line_bg"))
        centerView.addSubview(contentBackgroundView)
        contentBackgroundView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(289)
        }
        
  
        centerView.addSubview(leftView)
        leftView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-23)
            make.left.equalToSuperview()
            make.width.equalTo(35)
            make.height.equalTo(44 * numbers.count)
        }
        
        
        centerView.addSubview(rightView)
        rightView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.left.equalTo(leftView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.height.equalTo((numbers.count - 1) * 44 + 27)
        }
        
    }
    
    override func loadData() {
        super.loadData()
        titleLabel.text = item.title
        leftView.reloadData()
        rightView.reloadData()
    }
}

extension ChartsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChartsLeftCell", for: indexPath)
        if let cell = cell as? ChartLeftCell {
            cell.title = leftDatasource[indexPath.row]
        }
        return cell
    }
}

extension ChartsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bottomDataource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartsRightCell", for: indexPath)
        if let cell = cell as? ChartsRightCell {
            cell.model = rightDatasource[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 32
        let height = (numbers.count - 1) * 44 + 27
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension ChartsVC {
    
    @objc func lastAction() {
        var index = (ChartsItem.allCases.firstIndex(of: item) ?? 0) + ChartsItem.allCases.count
        index -= 1
        item = ChartsItem.allCases[index % ChartsItem.allCases.count]
    }
    
    @objc func nextAction() {
        var index = (ChartsItem.allCases.firstIndex(of: item) ?? 0) + ChartsItem.allCases.count
        index += 1
        item = ChartsItem.allCases[index % ChartsItem.allCases.count]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
