//
//  TopicCollectionViewCell.swift
//  ViewerModule
//
//  Created by Himanshu Ingole3 on 2/17/19.
//

import Kingfisher
import UIKit

/// Aritcle collection view
class ArticleCollectionViewCell: UICollectionViewCell {
    /// display article title
    @IBOutlet private weak var topicLabel: UILabel!
    /// display article image
    @IBOutlet private weak var imageView: UIImageView!

    func configure(_ viewModel: ArticleViewModelType?) {
        guard let viewModel = viewModel else {
            return
        }
        topicLabel.text = viewModel.title
        imageView.kf.indicatorType = .activity
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        let url = URL(string: viewModel.imageUrl)
        let placeHolderImage = UIImage(named: "placeHolder",
                                       in: Bundle(for: ArticleModule.self),
                                       compatibleWith: nil)
        imageView.kf.setImage(with: url, placeholder: placeHolderImage)
        imageView.kf.setImage(with: url,
                              placeholder: placeHolderImage,
                              options: [.processor(processor)])
    }
}
