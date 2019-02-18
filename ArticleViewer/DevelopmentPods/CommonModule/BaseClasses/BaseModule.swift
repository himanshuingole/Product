//
//  BaseModule.swift
//  CommonModule-CommonModule
//
//  Created by Himanshu Ingole3 on 2/17/19.
//

import Foundation
import UIKit
open class BaseModule: NSObject {
}

public protocol BaseType {
    static func representedName() -> String
}

extension BaseType {
    public func representedName() -> String {
        return type(of: self).representedName()
    }
}

public protocol AuthenticationModuleProtocol {
    func viewControllerForAuthenticatedState() -> UIViewController
}
