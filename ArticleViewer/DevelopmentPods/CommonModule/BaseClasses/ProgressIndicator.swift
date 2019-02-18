//
//  ProgressIndicator.swift
//  CommonModule
//
//  Created by Himanshu Ingole3 on 2/17/19.
//

import Foundation
import IHProgressHUD

public struct ProgressIndicator {
    public static func showIndicator(with status: String) {
        IHProgressHUD.set(defaultStyle: .dark)
        IHProgressHUD.show(withStatus: status)
    }

    public static func hideIndicator() {
        IHProgressHUD.dismiss()
    }
}
