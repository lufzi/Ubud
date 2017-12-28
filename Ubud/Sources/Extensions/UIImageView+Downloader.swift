//
//  UIImageView+Downloader.swift
//  Ubud
//
//  Created by Luqman Fauzi on 23/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

internal extension UIImageView {

    /// Download and cache image
    /// The cache mecanism is on memory only.
    ///
    /// - Parameters:
    ///   - url: `String`
    ///   - defaultImage: `UIImage`
    ///   - completion: hanler upon got the image
    func download(url: URL, defaultImage: UIImage = UIImage(), completion: ((_ image: UIImage) -> Void)?) {

        let urlString = url.absoluteString
        let cacheKey = urlString

        if let cachedImage = ImageCache.shared.get(key: cacheKey) {
            /// Return cached image
            completion?(cachedImage)
        } else {
            DispatchQueue.global().async (execute: {
                guard let url = URL(string: urlString) else {
                    /// Invalid URL
                    DispatchQueue.main.sync(execute: {
                        completion?(defaultImage)
                    })
                    return
                }
                guard let data = try? Data(contentsOf: url), let downloadedImage = UIImage(data: data) else {
                    /// Invalid raw image data
                    DispatchQueue.main.sync(execute: {
                        completion?(defaultImage)
                    })
                    return
                }
                DispatchQueue.main.sync (execute: {
                    /// Set the downloaded image
                    ImageCache.shared.set(key: cacheKey, image: downloadedImage)
                    completion?(downloadedImage)
                })
            })
        }
    }
}
