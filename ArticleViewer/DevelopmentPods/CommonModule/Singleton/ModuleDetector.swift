//
//  ModuleDetector.swift
//  CommonModule
//
//  Created by Himanshu Ingole3 on 2/10/19.
//

import Foundation
public class ModuleDetector {
    static let sharedInstance = ModuleDetector()
    var moduleDictionary: [String: BaseType] = [:]

    private init() {
    }

    func registerModule(module: BaseType,
                        name: String?) {
        let moduleName = name ?? type(of: module).representedName()
        if moduleDictionary[moduleName] == nil {
            moduleDictionary[moduleName] = module
        }
    }

    func getModule<T>(ofType type: T.Type) -> T? {
        for module in moduleDictionary.values {
            if let module = module as? T {
                return module
            }
        }
        return nil
    }

    func getModule(moduleName: String) -> BaseType? {
        return moduleDictionary[moduleName.lowercased()]
    }
}
