//
//  UbudCollectionPhotoCell.swift
//  Ubud
//
//  Created by Luqman Fauzi on 23/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

final class UbudCollectionPhotoCell: UICollectionViewCell {

    private lazy var activityIndicator: UIActivityIndicatorView = { [unowned self] in
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicatorView.frame.size = CGSize(width: 60.0, height: 60.0)
        indicatorView.center = self.contentView.center
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()

    private lazy var scrollView: UIScrollView = { [unowned self] in
        let scrollView = UIScrollView(frame: self.contentView.frame)
        scrollView.contentSize = CGSize(
            width: self.contentView.bounds.width,
            height: self.contentView.bounds.height + (self.contentView.bounds.height * 0.1)
        )
        scrollView.maximumZoomScale = 2.0
        scrollView.delegate = self
        scrollView.decelerationRate = UIScrollViewDecelerationRateFast
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        return scrollView
    }()

    private lazy var photoImageView: UIImageView = { [unowned self] in
        let imageView = UIImageView(frame: scrollView.frame)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(scrollView)
        scrollView.addSubview(photoImageView)
        photoImageView.addSubview(activityIndicator)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Public Methods

    public func configureImage(_ image: UIImage) {
        activityIndicator.stopAnimating()
        photoImageView.image = image
    }

    public func configureImage(_ url: String?, placeholder: UIImage? = nil) {
        guard let url = url, let imageURL = URL(string: url) else {
            if let placeholder = placeholder {
                photoImageView.image = placeholder
            }
            return
        }
        activityIndicator.startAnimating()
        photoImageView.download(imageURL, completion: { [unowned self] (image) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if let image = image {
                    self.photoImageView.image = image
                } else {
                    if let placeholder = placeholder {
                        self.photoImageView.image = placeholder
                    }
                }
            }
        })
    }
}

extension UbudCollectionPhotoCell: UIScrollViewDelegate {

    // MARK: - UIScrollViewDelegate

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale == 0 {
            scrollView.contentSize = CGSize(width: self.contentView.bounds.width, height: self.contentView.frame.height + 1.0)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        return
    }
}
