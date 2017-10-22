//
//  UbudConfig.swift
//  Ubud
//
//  Created by Luqman Fauzi on 22/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

open class UbudConfig {

    public static let shared = UbudConfig()

    private init() { }

    public var isStatusBarHidden: Bool = false
    public var statusBarStyle: UIStatusBarStyle = .default
}
