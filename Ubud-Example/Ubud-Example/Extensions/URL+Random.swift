//
//  URL+Random.swift
//  Ubud-Example
//
//  Created by Luqman Fauzi on 10/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import Foundation

typealias ImageURL = (thumbnailURL: URL, url: URL)

extension URL {

    static func generateRandomImageURLs(count: Int = 10) -> [ImageURL] {
        var randomURLs: [ImageURL] = []
        let baseURL = "https://picsum.photos"

        for _ in 1...count {
            let query = "?image=\(Int.random(upper: 100))"
            guard
                let thumbnailURL = URL(string: baseURL + "/600/600" + query),
                let url = URL(string: baseURL + "/1200/700" + query)
            else {
                break
            }
            let imageURL: ImageURL = (thumbnailURL, url)
            randomURLs.append(imageURL)
        }
        return randomURLs
    }
}
