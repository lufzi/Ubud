//
//  RemoteResourceViewController.swift
//  Ubud-Example
//
//  Created by Luqman Fauzi on 10/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit
import Ubud

private let reuseIdentifier = "ImageCell"

final class RemoteResourceViewController: UICollectionViewController {

    private lazy var urls: [ImageURL] = {
        return URL.generateRandomImageURLs(count: 20)
    }()

    init() {
        let layout = ImagesFlowLayout()
        super.init(collectionViewLayout: layout)
        self.title = "Image URLs"
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

extension RemoteResourceViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCell else {
            fatalError("Cell not found")
        }
        let url = urls[indexPath.item]
        cell.configure(url: url.thumbnailURL, indexPath: indexPath)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UbudController.show(
            presentedBy: self,
            dataSource: self,
            paginationDelegate: self,
            atIndex: indexPath.item
        )
    }
}

extension RemoteResourceViewController: UbudControllerDataSource {

    // MARK: - UbudControllerDataSource

    func numberOfOPhotos(in controller: UbudController) -> Int {
        return urls.count
    }

    func imageSourceForItem(in controller: UbudController, atIndex index: Int) -> PhotoDataSource {
        let imageURL = urls[index].url.absoluteString
        return .url(imageURL)
    }
}

extension RemoteResourceViewController: UbudControllerPaginationDelegate {

    // MARK: - UbudControllerPaginationDelegate

    func imagesPaginationStyle(in controller: UbudController) -> ImagesPaginationStyle? {
        return .textIndicator
    }

    func imagesPaginationDidChange(in controller: UbudController, atIndex index: Int) {
        print("Did change at: \(index)")
    }
}
