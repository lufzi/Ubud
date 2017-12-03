//
//  UbudControllerDataSource.swift
//  Ubud
//
//  Created by Luqman Fauzi on 03/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

public protocol UbudControllerDataSource: class {

    /// The number of photos
    ///
    /// - Parameter controller: `UbudController`
    /// - Returns: `Int`
    func numberOfOPhotos(in controller: UbudController) -> Int

    /// The `UIImage` of item in particular `IndexPath`
    ///
    /// - Parameters:
    ///   - controller: `UbudController`
    ///   - index: `Int`
    /// - Returns: `UIImage?`
    func photoImageForItem(in controller: UbudController, atIndex index: Int) -> UIImage?

    /// The `String` URL of item in particular `IndexPath`
    ///
    /// - Parameters:
    ///   - controller: `UbudController`
    ///   - index: `Int`
    /// - Returns: `String?`
    func photoURLForItem(in controller: UbudController, atIndex index: Int) -> String?
}

public extension UbudControllerDataSource {

    func photoImageForItem(in controller: UbudController, atIndex index: Int) -> UIImage? {
        return nil
    }

    func photoURLForItem(in controller: UbudController, atIndex index: Int) -> String? {
        return nil
    }
}
