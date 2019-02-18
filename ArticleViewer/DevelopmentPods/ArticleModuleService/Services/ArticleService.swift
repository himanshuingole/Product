//
//  ArticleService.swift
//  NetworkService
//
//  Created by Himanshu Ingole3 on 2/17/19.
//
import CommonModule
import Foundation
import NetworkService
import SwiftyJSON

class ArticleService: ServiceCallBase, ArticleServiceType {
    enum Key: String {
        case relatedTopics = "RelatedTopics"
        case api = "productApiUrl"
    }

    override init() {
        super.init()
        if let bundleApiUrl = Bundle.main.object( forInfoDictionaryKey: Key.api.rawValue ) as? String {
            apiUrl = bundleApiUrl
        } else {
            apiUrl = "http://api.duckduckgo.com/?q=simpsons+characters&format=json"
        }
    }

    func serialize(_ json: JSON) -> [ArticleModel] {
        var serializeItems: [ArticleModel] = []
        guard let responseDic = json.dictionary,
            let relatedTopics = responseDic[Key.relatedTopics.rawValue]?.array else {
                return serializeItems
        }
        serializeItems = relatedTopics.compactMap(ArticleModel.init)
        return serializeItems
    }

    public func getArticle(completion: @escaping ((ServiceResultType<[ArticleModel]>) -> Void)) {
        sendRequest { result in
            switch result {
            case .success(let json):
                guard let responseDic = json.dictionary,
                    let relatedTopics = responseDic[Key.relatedTopics.rawValue]?.array else {
                        completion(ServiceResultType.success([]))
                        return
                }
                completion(ServiceResultType.success(relatedTopics.compactMap(ArticleModel.init)))
            case .failure(let error):
                completion(ServiceResultType.failure(error))
            }
        }
    }
}

extension ArticleService: NetworkListenerServiceType {
    static func networkStatus(listener: ((Bool) -> Void)?) {
        NetworkManager.shared.bind(listener: listener)
    }
}
