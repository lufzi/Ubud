//
//  UbudControllerDisplayDelegate.swift
//  Ubud
//
//  Created by Luqman Fauzi on 03/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

public protocol UbudControllerDelegate: class {
    func numberOfOPhotos(in controller: UbudController) -> Int
    func photoImageForItem(in controller: UbudController, atIndex index: Int) -> UIImage?
    func photoURLForItem(in controller: UbudController, atIndex index: Int) -> String?
}

public extension UbudControllerDelegate {

    func photoImageForItem(in controller: UbudController, atIndex index: Int) -> UIImage? {
        return nil
    }

    func photoURLForItem(in controller: UbudController, atIndex index: Int) -> String? {
        return nil
    }
}
