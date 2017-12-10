//
//  ImagesFlowLayout.swift
//  Ubud-Example
//
//  Created by Luqman Fauzi on 10/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

final class ImagesFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth * 0.5 - 15.0
        itemSize = CGSize(width: itemWidth, height: itemWidth)
        sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        minimumLineSpacing = 10.0
        minimumInteritemSpacing = 5.0
        scrollDirection = .vertical
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
