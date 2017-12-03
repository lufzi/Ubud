//
//  UbudControllerDelegate.swift
//  Ubud
//
//  Created by Luqman Fauzi on 03/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

public enum DismissButtonContent {
    case image(UIImage)
    case text(String)
}

public protocol UbudControllerDelegate: class {

    /// `UIStatusBarStyle` display state of controller
    ///
    /// - Parameter controller: `UbudController`
    /// - Returns: `Bool`
    func statusBarHidden(in controller: UbudController) -> Bool

    /// `UIStatusBarStyle` display style of controller
    ///
    /// - Parameter controller: `UbudController`
    /// - Returns: `UIStatusBarStyle`
    func statusBarStyle(in controller: UbudController) -> UIStatusBarStyle

    /// The dismiss button of controller
    ///
    /// - Parameter controller: `UbudController`
    /// - Returns: `DismissButtonContent`
    func dismissButtonContent(in controller: UbudController) -> DismissButtonContent
}

public extension UbudControllerDelegate {

    func statusBarHidden(in controller: UbudController) -> Bool {
        return false
    }

    func statusBarStyle(in controller: UbudController) -> UIStatusBarStyle {
        return .lightContent
    }

    func dismissButtonContent(in controller: UbudController) -> DismissButtonContent {
        return .text("Dismiss")
    }
}
