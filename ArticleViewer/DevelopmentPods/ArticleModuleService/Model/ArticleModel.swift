//
//  ArticleModel.swift
//  ArticleModuleService
//
//  Created by Himanshu Ingole3 on 2/17/19.
//

import Foundation
import SwiftyJSON

public struct ArticleModel {
    public var firstUrl: String
    public var iconUrl: String
    public var text: String
    public var result: String

    enum Key: String {
        case firstURL = "FirstURL"
        case icon = "Icon"
        case URL = "URL"
        case text = "Text"
        case result = "Result"
    }

    public init(json: JSON) {
        firstUrl = json[Key.firstURL.rawValue].string ?? ""
        iconUrl = json[Key.icon.rawValue].dictionary?[Key.URL.rawValue]?.string ?? ""
        text = json[Key.text.rawValue].string ?? ""
        result = json[Key.result.rawValue].string ?? ""
    }
}
