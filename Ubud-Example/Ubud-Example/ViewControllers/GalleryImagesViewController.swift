//
//  GalleryImagesViewController.swift
//  Ubud-Example
//
//  Created by Luqman Fauzi on 23/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit
import Ubud

private let reuseIdentifier = "GalleryCell"

final class GalleryImagesViewController: UICollectionViewController {

    private let images: [UbudImage] = [
        UbudImage(image: UIImage(named: "ubud-sample-1")),
        UbudImage(image: UIImage(named: "ubud-sample-2")),
        UbudImage(image: UIImage(named: "ubud-sample-3")),
        UbudImage(image: UIImage(named: "ubud-sample-4")),
        UbudImage(image: UIImage(named: "ubud-sample-5"))
    ]

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
        layout.minimumLineSpacing = 15.0
        layout.minimumInteritemSpacing = 15.0
        layout.itemSize = CGSize(width: 150.0, height: 150.0)
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
        self.title = "Example 1"
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.backgroundColor = UIColor.groupTableViewBackground
        collectionView?.alwaysBounceVertical = true
    }
}

extension GalleryImagesViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GalleryCell else {
            fatalError("Cell not found")
        }
        if let image = images[indexPath.item].image {
            cell.configure(image: image)
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UbudController.show(presentedBy: self, delegate: self, atIndex: indexPath.item)
    }
}

extension GalleryImagesViewController: UbudControllerDelegate {

    // MARK: - UbudControllerDelegate

    func numberOfOPhotos(in controller: UbudController) -> Int {
        return images.count
    }

    func photoImageForItem(in controller: UbudController, atIndex index: Int) -> UIImage? {
        return images[index].image
    }

    func photoURLForItem(in controller: UbudController, atIndex index: Int) -> String? {
        return nil
    }
}
