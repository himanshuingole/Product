//
//  ArticleServiceDispatcher.swift
//  NetworkService
//
//  Created by Himanshu Ingole3 on 2/17/19.
//
import CommonModule
import Foundation

public protocol NetworkListenerServiceType {
    static func networkStatus(listener: ((Bool) -> Void)?)
}

public protocol ArticleServiceType: NetworkListenerServiceType {
    func getArticle(completion: @escaping ((ServiceResultType<[ArticleModel]>) -> Void))
}

open class ArticleServiceDispatcher {
    public static let sharedInstance = ArticleServiceDispatcher()

    private init() {
    }
}

extension ArticleServiceDispatcher: ArticleServiceType {
    public static func networkStatus(listener: ((Bool) -> Void)?) {
        ArticleService.networkStatus(listener: listener)
    }

    /// Article service request
    /// This place can be used to mock the service.
    /// - Parameter completion: completion handler
    public func getArticle(completion: @escaping ((ServiceResultType<[ArticleModel]>) -> Void)) {
        let service = ArticleService()
        service.getArticle(completion: completion)
    }
}
