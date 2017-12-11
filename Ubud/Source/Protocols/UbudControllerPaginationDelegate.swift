//
//  UbudControllerPaginationDelegate.swift
//  Ubud
//
//  Created by Luqman Fauzi on 11/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import Foundation

public enum ImagesPaginationStyle {
    case textIndicator
    case dotIndicator
}

public protocol UbudControllerPaginationDelegate: class {

    func imagesPaginationStyle(in controller: UbudController) -> ImagesPaginationStyle?

    func imagesPaginationDidChange(in controller: UbudController, atIndex index: Int)
}

public extension UbudControllerPaginationDelegate {

    func imagesPaginationStyle(in controller: UbudController) -> ImagesPaginationStyle? {
        return nil
    }

    func imagesPaginationDidChange(in controller: UbudController, atIndex index: Int) {
        return
    }
}
