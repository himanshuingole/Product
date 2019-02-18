//
//  MasterVCModel.swift
//  ViewerModuleService
//
//  Created by Himanshu Ingole3 on 2/17/19.
//

import ArticleModuleService
import CommonModule

/// Article list view model type
protocol ArticleListViewModelType {
    /// RX Swift behaviour subject logic
    var loading: Behaviour<Bool> { get set }

    /// errorHandler - pass errors from viewmodel to viewcontroller
    var errorHandler: ((String?, String) -> Void)? { get set }

    /// Load data from server
    ///
    /// - Parameter completion: completion handler return true or false based on api call success
    /// - Returns:
    func dataLoad(completion: @escaping (Bool) -> Void)

    /// return number of items received from api
    ///
    /// - Returns: return count of items received from api
    func numberOfItems() -> Int

    /// returns Article view model
    ///
    /// - Parameter index: item index
    /// - Returns: Article view model
    func item(for index: Int) -> ArticleViewModelType
}

/// Adop ArticleListViewModelType
class ArticleListViewModel: ArticleListViewModelType {
    /// Article service
    private var service: ArticleServiceType

    /// viewmodel holds receivd items from api by default it contains empty array
    private var viewModels: [ArticleViewModelType] = []

    var errorHandler: ((String?, String) -> Void)?
    var loading = Behaviour(false)

    init(service: ArticleServiceType = ArticleServiceDispatcher.sharedInstance) {
        self.service = service
    }

    func dataLoad(completion: @escaping (Bool) -> Void) {
        /// loading value changed which will be notified to VC by listener
        loading.value = true
        /// Dispatcher receved request for article which future passed to service layer
        service.getArticle {[unowned self] result in
            /// After receiving response, loading value changed to hide the loading
            self.loading.value = false
            switch result {
            case .success(let items):
                /// Received the sucess response, now its time to convert them into view model
                self.viewModels = items.compactMap(ArticleViewModel.init)
                completion(true)
            case .failure(let error):
                /// received error
                /// check for device offline - if yes then start listening network and try to refetch the request
                if error.isDeviceOffline() {
                    /// This can be improve by making instace method
                    ArticleServiceDispatcher.networkStatus(listener: { [unowned self] in
                        if $0 {
                            /// if network is reenable then rehit the service
                            self.dataLoad(completion: completion)
                            /// stop receiving network status
                            ArticleServiceDispatcher.networkStatus(listener: nil)
                        }
                    })
                }
                /// pass error info to viewcontroller to display to the user
                self.errorHandler?(nil, error.errorDescription() ?? error.localizedDescription)
                completion(false)
            }
        }
    }

    func numberOfItems() -> Int {
        return viewModels.count
    }

    func item(for index: Int) -> ArticleViewModelType {
        return viewModels[index]
    }
}
