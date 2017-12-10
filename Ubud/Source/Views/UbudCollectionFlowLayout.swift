//
//  UbudCollectionFlowLayout.swift
//  Ubud
//
//  Created by Luqman Fauzi on 22/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

internal final class UbudCollectionFlowLayout: UICollectionViewFlowLayout {

    init(collectionViewSize: CGSize) {
        super.init()
        itemSize = collectionViewSize
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
