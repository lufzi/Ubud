//
//  UIImage+Random.swift
//  Ubud-Example
//
//  Created by Luqman Fauzi on 10/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

extension UIImage {
    class func generateRandomImages(count: Int = 10) -> [UIImage] {
        var randomImages: [UIImage] = []
        for _ in 1...count {
            if let image = UIImage(named: "ubud-sample-\(Int.random10)") {
                randomImages.append(image)
            }
        }
        return randomImages
    }
}
