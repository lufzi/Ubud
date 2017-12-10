//
//  UIImageView+Downloader.swift
//  Ubud-Example
//
//  Created by Luqman Fauzi on 10/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

private let cache = NSCache<NSString, UIImage>()

extension UIImageView {

    func download(url: URL, defaultImage: UIImage = UIImage(), completion: ((_ image: UIImage) -> Void)?) {

        let urlString = url.absoluteString
        let cacheKey = urlString as NSString

        if let cachedImage = cache.object(forKey: cacheKey) {
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
                    cache.setObject(downloadedImage, forKey: cacheKey)
                    completion?(downloadedImage)
                })
            })
        }
    }
}
