//
//  GalleryCell.swift
//  Ubud-Example
//
//  Created by Luqman Fauzi on 23/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

final class GalleryCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(image: UIImage) {
        imageView.image = image
    }
}
