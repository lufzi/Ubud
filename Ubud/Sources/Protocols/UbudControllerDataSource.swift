//
//  UbudControllerDataSource.swift
//  Ubud
//
//  Created by Luqman Fauzi on 03/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

public enum PhotoDataSource {
    case image(UIImage)
    case url(String)
}

public protocol UbudControllerDataSource: class {

    /// The number of photos
    ///
    /// - Parameter controller: `UbudController`
    /// - Returns: `Int`
    func numberOfOPhotos(in controller: UbudController) -> Int

    /// The data source of image for particular `IndexPath`
    ///
    /// - Parameters:
    ///   - controller: `UbudController`
    ///   - index: `Int`
    /// - Returns: `PhotoDataSource?`
    func imageSourceForItem(in controller: UbudController, atIndex index: Int) -> PhotoDataSource
}
