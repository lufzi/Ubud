//
//  UIImageView+Downloader.swift
//  Ubud
//
//  Created by Luqman Fauzi on 23/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

internal extension UIImageView {
    func download(_ url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil {
                completion(nil)
            } else if let data = data, let image = UIImage(data: data) {
                completion(image)
            }
        }
        dataTask.resume()
    }
}
