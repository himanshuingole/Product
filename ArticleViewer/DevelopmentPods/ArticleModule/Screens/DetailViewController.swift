//
//  DetailViewController.swift
//  ArticleModule
//
//  Created by Himanshu Ingole3 on 2/17/19.
//
import Kingfisher
import UIKit

/// Article details view controller
class DetailViewController: UIViewController {
//    view module received from master view controller
    var detailsVM: ArticleViewModelType?

//    details label for holding details
    @IBOutlet private weak var detailsLabel: UILabel!
//    article image
    @IBOutlet private weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }

    func configureView() {
        guard let detailsVM = detailsVM else {
            return
        }
        detailsLabel.text = detailsVM.desc
        imageView.kf.indicatorType = .activity
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        let url = URL(string: detailsVM.imageUrl)
        let placeHolderImage = UIImage(named: "placeHolder",
                                       in: Bundle(for: ArticleModule.self),
                                       compatibleWith: nil)
        imageView.kf.setImage(with: url, placeholder: placeHolderImage)
        imageView.kf.setImage(with: url,
                              placeholder: placeHolderImage,
                              options: [.processor(processor)])
    }
}
