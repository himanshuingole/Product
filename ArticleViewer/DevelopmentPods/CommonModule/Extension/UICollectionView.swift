//
//  UICollectionView.swift
//  CommonModule
//
//  Created by Himanshu Ingole3 on 2/17/19.
//

import Foundation
import UIKit

extension UICollectionView {
    public func cell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseableIdentifier,
                                             for: indexPath) as? T else {
                                                fatalError("unable to load cell for" +
                                                    "indentifer\(T.reuseableIdentifier)")
        }
        return cell
    }

    public func header<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        guard let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                            withReuseIdentifier: T.reuseableIdentifier,
                                                            for: indexPath) as? T else {
                                                                fatalError("unable to load cell for" +
                                                                    "headerView\(T.reuseableIdentifier)")
        }
        return header
    }
}
