//
//  UIImageView+Downloader.swift
//  Ubud-Example
//
//  Created by Luqman Fauzi on 10/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

extension UIImageView {

    func download(_ url: URL, completion: @escaping (_ image: UIImage?) -> Void) {

        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil

        let session = URLSession(configuration: config)

        let dataTask = session.dataTask(with: url) { (data, _, error) in
            if error != nil {
                completion(nil)
            } else if let data = data, let image = UIImage(data: data) {
                completion(image)
            }
        }

        dataTask.resume()
    }
}
