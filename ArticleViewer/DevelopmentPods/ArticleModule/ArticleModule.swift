//
//  ViewerModule.swift
//  ArticleModule
//
//  Created by Himanshu Ingole3 on 2/17/19.
//
import CommonModule
import Foundation
import UIKit

enum Storyboard: String {
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue,
                            bundle: Bundle(for: ArticleModule.self))
    }

    case article = "Article"
}
open class ArticleModule: BaseModule {}

extension ArticleModule: ArticleFlowInitiator {
    public func flowInitiatorForViewerModule() -> UISplitViewController? {
        guard let splitViewController = Storyboard.article.instance
        .instantiateInitialViewController() as? UISplitViewController,
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count - 1]
                as? UINavigationController,
            let topViewController = navigationController.topViewController else {
                return nil
        }
        topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        return splitViewController
    }
}
