//
//  ReusableViewType.swift
//  CommonModule
//
//  Created by Himanshu Ingole3 on 2/17/19.
//

import Foundation

protocol ReusableViewType {
    static var reuseableIdentifier: String { get }
}

extension ReusableViewType {
    static var reuseableIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewType {}

extension UICollectionReusableView: ReusableViewType {}
