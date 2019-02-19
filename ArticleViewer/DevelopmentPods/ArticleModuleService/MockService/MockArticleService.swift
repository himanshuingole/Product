//
//  MockArticleService.swift
//  ArticleModuleService
//
//  Created by Himanshu Ingole3 on 2/18/19.
//

import CommonModule
import Foundation
import NetworkService
import SwiftyJSON

class MockArticleService: ArticleService {
    enum MockType {
        case sucess
        case fail
        case devicefail
    }

    public var mockType = MockType.sucess

    override func sendRequest(completion: ((ServiceResultType<JSON>) -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
            // swiftlint:disable line_length

            let jsonRespnse = """
{"ImageIsLogo":0,"RelatedTopics":[{"Result":"","FirstURL":"https://duckduckgo.com/Apu_Nahasapeemapetilon","Text":"Barney Gumble - test item","Icon":{"Height":"","Width":"","URL":"https://duckduckgo.com/i/99b04638.png"}},{"Icon":{"URL":"https://duckduckgo.com/i/39ce98c0.png","Width":"","Height":""},"Result":"","Text":"Gumble Game - test item","FirstURL":"https://duckduckgo.com/Barney_Gumble"}]}
"""
            // swiftlint:enable line_length

            switch self.mockType {
            case .sucess:
                completion?(ServiceResultType.success(JSON(parseJSON: jsonRespnse)))
            case .fail:
                completion?(ServiceResultType.failure(NSError(domain: "customError",
                                                              code: 200,
                                                              userInfo: nil)))
            case .devicefail:
                completion?(ServiceResultType.failure(NSError(domain: "d",
                                                              code: -1009,
                                                              userInfo: nil)))
            }
        }
    }
}
