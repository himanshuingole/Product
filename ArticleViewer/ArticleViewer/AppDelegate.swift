//
//  AppDelegate.swift
//  ArticleViewer
//
//  Created by Himanshu Ingole3 on 2/17/19.
//

import ArticleModule
import CommonModule
import NetworkService
import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// Article module - This should come from module delgator as its onlh one module
        /// therefore its fine to use direct
        let articleModule = ArticleModule()
        window = UIWindow(frame: UIScreen.main.bounds)
        if let splitVC = articleModule.flowInitiatorForViewerModule(),
           let navCnt = splitVC.viewControllers[splitVC.viewControllers.count - 1] as? UINavigationController,
            let topViewController = navCnt.topViewController {
            topViewController.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
            window?.rootViewController = splitVC
        }
        window?.makeKeyAndVisible()
        return true
    }
}
