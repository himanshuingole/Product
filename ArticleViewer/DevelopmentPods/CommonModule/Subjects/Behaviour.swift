//
//  Behaviour.swift
//  CommonModule
//
//  Created by Himanshu Ingole3 on 2/17/19.
//

import Foundation
public struct Behaviour <T> {
    var listener: ((T) -> Void)?
    public var value: T {
        didSet {
            listener?(value)
        }
    }

    public init(_ value: T) {
        self.value = value
    }

    public mutating func bind(listener: ((T) -> Void)?) {
        self.listener = listener
        listener?(value)
    }
}
