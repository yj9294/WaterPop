//
//  AppDelegate.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        addLoadingLife()
        NotificationUtil.shared.register()
        NotificationCenter.default.post(name: .applicationLoading, object: nil)
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.post(name: .applicationLoading, object: nil)
    }
    
}

extension AppDelegate {
    
    func addLoadingLife() {
        NotificationCenter.default.addObserver(forName: .applicationLoading, object: nil, queue: .main) { [weak self] _ in
            if let vc = self?.window?.rootViewController, let vc = vc as? LoadingVC {
                vc.startLoading()
            } else {
                self?.window?.rootViewController = LoadingVC()
                self?.window?.makeKeyAndVisible()
            }
        }
        
        NotificationCenter.default.addObserver(forName: .applicationHome, object: nil, queue: .main) { [weak self] _ in
            self?.window?.rootViewController = HomeVC()
            self?.window?.makeKeyAndVisible()
        }
    }
    
}

extension Notification.Name {
    static let applicationLoading = Notification.Name(rawValue: "application.loading")
    static let applicationHome = Notification.Name(rawValue: "applciation.home")
}
