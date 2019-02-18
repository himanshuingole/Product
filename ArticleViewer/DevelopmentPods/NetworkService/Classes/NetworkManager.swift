//
//  NetworkManager.swift
//  NetworkService
//
//  Created by Himanshu Ingole3 on 2/17/19.
//
import Alamofire
import Foundation

open class NetworkManager {
    //shared instance
    public static let shared = NetworkManager()

    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")

    init() {
        // start listening
        reachabilityManager?.startListening()
    }

    public func bind(listener: ((Bool) -> Void)?) {
       reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
               listener?(false)

            case .unknown :
               listener?(false)

            case .reachable(.ethernetOrWiFi):
                listener?(true)

            case .reachable(.wwan):
                listener?(true)
            }
        }
    }
}
