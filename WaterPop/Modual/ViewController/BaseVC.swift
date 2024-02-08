//
//  BaseVC.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/29.
//

import UIKit
import SnapKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("\(self) load 🈶️🈶️🈶️");
        setupUI()
        loadData()
    }

    deinit{
        debugPrint("\(self) delloc 🈚️🈚️🈚️");
    }
}

extension BaseVC {
    @objc func setupUI() {}
    
    @objc func loadData() {}
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
}
