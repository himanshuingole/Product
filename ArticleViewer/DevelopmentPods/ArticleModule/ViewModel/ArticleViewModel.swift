//
//  ArticleViewModel.swift
//  ArticleModule
//
//  Created by Himanshu Ingole3 on 2/17/19.
//
import ArticleModuleService
import Foundation

protocol ArticleViewModelType {
    var title: String { get }
    var desc: String { get }
    var imageUrl: String { get }
}

struct ArticleViewModel: ArticleViewModelType {
    var article: ArticleModel

    init(article: ArticleModel) {
        self.article = article
    }

    var title: String {
        return article.text.components(separatedBy: "-")[0]
    }

    var imageUrl: String {
        return article.iconUrl
    }

    var desc: String {
        return article.text
    }
}
