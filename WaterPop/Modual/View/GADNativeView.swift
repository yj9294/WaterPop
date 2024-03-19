//
//  GADNativeView.swift
//  WaterPop
//
//  Created by Super on 2024/3/18.
//

import Foundation
import GoogleMobileAds
import GADUtil

class GADNativeView: GADNativeAdView {
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = UIColor.init(hex: 0x525050)
        return label
    }()
    
    lazy var subTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = UIColor.init(hex: 0x858585)
        return label
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.layer.cornerRadius = 4
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    lazy var adTag: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ad_tag"))
        return imageView
    }()
    
    lazy var install: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.init(hex: 0x15AA00)
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var big: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var playView: GADMediaView = {
        let view = GADMediaView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    enum Style {
        case small, big
    }
    
    init(_ style: Style) {
        super.init(frame: .zero)
        self.style = style
        setupUI()
    }
    
    private var style: Style = .small
    
    override var nativeAd: GADNativeAd? {
        didSet {
            super.nativeAd = nativeAd
            title.text = nativeAd?.headline
            subTitle.text = nativeAd?.body
            icon.image = nativeAd?.icon?.image
            install.setTitle(nativeAd?.callToAction, for: .normal)
            big.image = nativeAd?.images?.first?.image
            playView.mediaContent = nativeAd?.mediaContent
            
            self.isHidden = nativeAd == nil
            updateConstraint()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(icon)
        addSubview(title)
        addSubview(subTitle)
        addSubview(install)
        addSubview(adTag)
        addSubview(big)
        addSubview(playView)
        iconView = icon
        headlineView = title
        bodyView = subTitle
        callToActionView = install
        advertiserView = adTag
        imageView = big
        mediaView = playView
    }
    
     func updateConstraint() {
        if style == .small {
            self.backgroundColor = .white
            icon.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(20)
                make.left.equalToSuperview().offset(16)
                make.width.height.equalTo(44)
            }
            title.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(19)
                make.left.equalTo(icon.snp.right).offset(13)
            }
            adTag.snp.makeConstraints { make in
                make.centerY.equalTo(title)
                make.right.equalToSuperview().offset(-10)
                make.left.equalTo(title.snp.right).offset(10)
            }
            subTitle.numberOfLines = 1
            subTitle.snp.makeConstraints { make in
                make.top.equalTo(title.snp.bottom).offset(7)
                make.right.equalToSuperview().offset(-22)
                make.left.equalTo(title)
            }
            install.snp.makeConstraints { make in
                make.top.equalTo(icon.snp.bottom).offset(8)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.height.equalTo(36)
            }
        } else {
            backgroundColor = .white
            big.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(14)
                make.left.equalToSuperview().offset(22)
                make.right.equalToSuperview().offset(-127)
                make.height.equalTo(110)
            }
            playView.snp.makeConstraints { make in
                make.top.left.right.bottom.equalTo(big)
            }
            
            icon.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(14)
                make.right.equalToSuperview().offset(-50)
                make.width.height.equalTo(36)
            }
            title.snp.makeConstraints { make in
                make.top.equalTo(icon.snp.bottom).offset(8)
                make.left.equalTo(big.snp.right).offset(12)
            }
            adTag.snp.makeConstraints { make in
                make.centerY.equalTo(title)
                make.left.equalTo(title.snp.right).offset(4)
                make.right.equalToSuperview().offset(-12)
                make.height.equalTo(12)
                make.width.equalTo(20)
            }
            
            install.snp.makeConstraints { make in
                make.top.equalTo(title.snp.bottom).offset(12)
                make.left.equalTo(title)
                make.right.equalToSuperview().offset(-12)
                make.height.equalTo(36)
            }
            
            subTitle.numberOfLines = 2
            subTitle.snp.makeConstraints { make in
                make.top.equalTo(big.snp.bottom).offset(8)
                make.left.equalTo(big)
                make.right.equalToSuperview().offset(-22)
            }
        }
    }
}
