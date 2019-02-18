//
//  Error+Extension.swift
//  CommonModule
//
//  Created by Himanshu Ingole3 on 2/17/19.
//

import Foundation
enum ErrorCode: Int {
    case deviceOffline = -1009
}

public extension Error {
    public var errorCode: Int? {
        return (self as NSError).code
    }

    public func isDeviceOffline() -> Bool {
        guard let errorCode = self.errorCode,
            errorCode == ErrorCode.deviceOffline.rawValue else {
                return false
        }
        return true
    }

    public func errorDescription() -> String? {
            switch (self as NSError).code {
            case ErrorCode.deviceOffline.rawValue:
                return "Please check your internet"
            default:
                return nil
            }
    }
}
