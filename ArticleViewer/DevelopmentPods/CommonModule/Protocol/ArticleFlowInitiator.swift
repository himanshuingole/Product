//
//  ArticleFlowInitiator.swift
//  CommonModule
//
//  Created by Himanshu Ingole3 on 2/17/19.
//

import Foundation
import UIKit

public protocol ArticleFlowInitiator {
    func flowInitiatorForViewerModule() -> UISplitViewController?
}
