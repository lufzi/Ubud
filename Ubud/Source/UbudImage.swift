//
//  UbudImage.swift
//  Ubud
//
//  Created by Luqman Fauzi on 22/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

open class UbudImage {

    open private(set) var url: String?
    open private(set) var image: UIImage?

    public init(url: String? = nil, image: UIImage? = nil) {
        self.url = url
        self.image = image
    }
}
