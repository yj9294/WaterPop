//
//  LoadingVC.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/29.
//

import UIKit

class LoadingVC: BaseVC {
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.backgroundColor =  UIColor(hex: 0xBBDAE8)
        progressView.tintColor = UIColor(hex: 0x61CFFF)
        progressView.layer.cornerRadius = 2
        progressView.layer.masksToBounds = true
        return progressView
    }()
    
    private var timer: Timer? = nil
    
    private var progress = 0.0 {
        didSet {
            progressView.progress = Float(progress)
        }
    }
    
    private let duration = 2.45

    override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
    }
    
}

extension LoadingVC {
    
    override func setupUI() {
        super.setupUI()
        
        let bg = UIImageView(image: UIImage(named: "bg"))
        bg.contentMode = .scaleAspectFill
        view.addSubview(bg)
        bg.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        let icon = UIImageView(image: UIImage(named: "loading_icon"))
        view.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(167)
            make.centerX.equalToSuperview()
        }
        
        let title = UIImageView(image: UIImage(named: "loading_title"))
        view.addSubview(title)
        title.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(-130)
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottomMargin).offset(-60)
            make.left.equalToSuperview().offset(70)
            make.right.equalToSuperview().offset(-70)
        }
    }
    
    public func startLoading() {
        timer?.invalidate()
        progress = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] timer in
            guard let self = self else { return }
            self.progress = self.progress + 0.01 / self.duration
            if self.progress > 1.0 {
                self.progress = 1.0
                timer.invalidate()
                NotificationCenter.default.post(name: .applicationHome, object: nil)
            }
        })
    }
}
