//
//  AppDelegate.swift
//  WaterPop
//
//  Created by yangjian on 2024/1/29.
//

import UIKit
import GADUtil
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions)
        addLoadingLife()
        NotificationUtil.shared.register()
        NotificationCenter.default.post(name: .applicationLoading, object: nil)
        GADUtil.share.requestConfig()
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.post(name: .applicationLoading, object: nil)
        if let windowScene = UIApplication.shared.connectedScenes.filter({$0 is UIWindowScene}).first as? UIWindowScene, let vc = windowScene.keyWindow?.rootViewController {
            if let presentedVC = vc.presentedViewController {
                if let vcc = presentedVC.presentedViewController {
                    vcc.dismiss(animated: true) {
                        presentedVC.dismiss(animated: true)
                    }
                } else {
                    presentedVC.dismiss(animated: true)
                }
            }
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func application(
            _ app: UIApplication,
            open url: URL,
            options: [UIApplication.OpenURLOptionsKey : Any] = [:]
        ) -> Bool {
            ApplicationDelegate.shared.application(
                app,
                open: url,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
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
