//
//  Int+Random.swift
//  Ubud-Example
//
//  Created by Luqman Fauzi on 10/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import Foundation

extension Int {
    static func random(upper: Int = 10) -> Int {
        let randomNumber: UInt32 = arc4random_uniform(UInt32(upper))
        return Int(randomNumber)
    }
}
