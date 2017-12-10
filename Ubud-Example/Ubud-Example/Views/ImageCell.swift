//
//  ImageCell.swift
//  Ubud-Example
//
//  Created by Luqman Fauzi on 23/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

final class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(image: UIImage) {
        activityIndicator.isHidden = true
        imageView.image = image
    }

    func configure(url: URL, indexPath: IndexPath) {
        activityIndicator.startAnimating()
        imageView.download(url, completion: { [unowned self] image in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.imageView.image = image
            }
        })
    }
}
