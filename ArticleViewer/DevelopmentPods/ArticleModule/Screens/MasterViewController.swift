//
//  MasterViewController.swift
//  ArticleModule
//
//  Created by Himanshu Ingole3 on 2/17/19.
//
import CommonModule
import UIKit

/// Masterviewcontroller - hold article listing
class MasterViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    /// detailsViewController refernce
    var detailViewController: DetailViewController?

    /// bool to toggle between list and grid view
    var isGridView: Bool = false

    /// View model contains all business logic
    var articleListViewModel = ArticleListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupToggleButton()
        setupDetailsViewController()
        fetchTopics()
        setupViewModelCompletionHandler()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    func setupNavigationBar() {
        title = Bundle.main.object(forInfoDictionaryKey: Keys.displayName.rawValue) as? String
    }

    func setupToggleButton() {
        let toggleButton = UIBarButtonItem(barButtonSystemItem: .compose,
                                           target: self,
                                           action: #selector(toggleItemPressed))
        navigationItem.rightBarButtonItem = toggleButton
    }

    func setupViewModelCompletionHandler() {
        articleListViewModel.loading.bind {
            $0 ? ProgressIndicator.showIndicator(with: Keys.loading.rawValue) : ProgressIndicator.hideIndicator()
        }
        articleListViewModel.errorHandler = errorHandlerCompletion()
    }

    func errorHandlerCompletion() -> ((String?, String) -> Void) {
        func onError(title: String?,
                     message: String) {
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            let okButton = UIAlertAction(title: Keys.okButtonTitle.rawValue,
                                         style: .default,
                                         handler: nil)
            alertController.addAction(okButton)
            present(alertController, animated: true, completion: nil)
        }
        return onError
    }

    @objc func toggleItemPressed() {
        isGridView = isGridView ? false : true
        collectionView.collectionViewLayout.invalidateLayout()
    }

    func setupDetailsViewController() {
        splitViewController?.delegate = self
        if let split = splitViewController {
            let controllers = split.viewControllers
            if let navCnt = controllers[controllers.count - 1] as? UINavigationController,
                let topCnt = navCnt.topViewController as? DetailViewController {
                detailViewController = topCnt
            }
        }
    }

    func fetchTopics() {
        articleListViewModel.dataLoad { [unowned self] _ in
            self.collectionView.reloadData()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleListViewModel.numberOfItems()
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ArticleCollectionViewCell = collectionView.cell(for: indexPath)
        cell.configure(articleListViewModel.item(for: indexPath.item))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - collectionView.contentInset.left + collectionView.contentInset.right
        return CGSize(width: isGridView ? 90 : width,
                      height: 70)
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Keys.detailsSeque.rawValue {
            if let indexPath = collectionView.indexPathsForSelectedItems?.first,
                let navCnt = segue.destination as? UINavigationController,
                let controller = navCnt.topViewController as? DetailViewController {
                controller.detailsVM = articleListViewModel.item(for: indexPath.item)
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}

extension MasterViewController {
    enum Keys: String {
        case displayName = "CFBundleName"
        case detailsSeque = "showDetail"
        case loading = "Loading topics..."
        case okButtonTitle = "Ok"
    }
}

extension MasterViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else {
            return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else {
            return false }
        if topAsDetailController.detailsVM == nil {
            // Return true to indicate that we have handled the collapse by doing nothing;
            //the secondary controller will be discarded.
            return true
        }
        return false
    }
}
