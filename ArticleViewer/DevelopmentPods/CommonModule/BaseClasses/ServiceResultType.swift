//
//  ServiceResultType.swift
//  CommonModule
//
//  Created by Himanshu Ingole3 on 2/17/19.
//

import Foundation

public enum ServiceResultType<T> {
    case success(T)
    case failure(Error)
}
