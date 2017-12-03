//
//  UbudControllerDelegate.swift
//  Ubud
//
//  Created by Luqman Fauzi on 03/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

public protocol UbudControllerDisplayDelegate: class {
    func isStatusBarHidden() -> Bool
    func statusBarStyle() -> UIStatusBarStyle
}

public extension UbudControllerDisplayDelegate {

    func isStatusBarHidden() -> Bool {
        return false
    }

    func statusBarStyle() -> UIStatusBarStyle {
        return .default
    }
}
