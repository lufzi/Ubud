//
//  UbudCollectionFlowLayout.swift
//  Ubud
//
//  Created by Luqman Fauzi on 22/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

open class UbudCollectionFlowLayout: UICollectionViewFlowLayout {

    public init(size: CGSize) {
        super.init()
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        itemSize = size
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
