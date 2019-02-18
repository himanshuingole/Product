//
//  ServiceCallBase.swift
//  NetworkService-NetworkService
//
//  Created by Himanshu Ingole3 on 2/12/19.
//
import Alamofire
import CommonModule
import Foundation
import SwiftyJSON
import UIKit

open class ServiceCallBase {
    open var apiUrl: String!

    public init () {
    }

    open func sendRequest(completion: ((ServiceResultType<JSON>) -> Void)?) {
        Alamofire.request(apiUrl).responseJSON { response in
            if let httpResponse = response.response {
               // print(httpResponse)
            }

            if let data = response.data,
                let responseString = String(data: data, encoding: .utf8) {
                // response body print
                //print(responseString)
            }
            DispatchQueue.main.async {
                switch response.result {
                case .success(let resultValue):
                    completion?(ServiceResultType.success(JSON(resultValue)))
                case .failure(let error):
                    completion?(.failure(error))
                }
            }
        }
    }
}
