//
//  UbudController.swift
//  Ubud
//
//  Created by Luqman Fauzi on 22/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "UbudCollectionPhotoCell"

open class UbudController: UIViewController {
    enum FocusState {
        case active, inactive
    }
    // MARK: Views
    private let screenFrame = UIScreen.main.bounds
    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UbudCollectionFlowLayout(size: screenFrame.size)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UbudCollectionPhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    private lazy var topContainerView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        return button
    }()
    private lazy var tapGesture: UITapGestureRecognizer = { [unowned self] in
        let gesture = UITapGestureRecognizer(target: self, action: #selector(updateFocusState))
        return gesture
    }()

    private var images: [UbudImage]!
    private var currentIndex: Int = 0
    private var selectedIndex: Int = 0
    private var state: FocusState = .inactive

    public init(images: [UbudImage], selectedIndex: Int) {
        self.images = images
        self.currentIndex = selectedIndex
        self.selectedIndex = selectedIndex
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        [collectionView, topContainerView].forEach { view.addSubview($0) }
        topContainerView.addSubview(closeButton)
        collectionView.addGestureRecognizer(tapGesture)
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            topContainerView.heightAnchor.constraint(equalToConstant: 70.0),
            topContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            topContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            closeButton.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: -8.0),
            closeButton.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -15.0)
        ])
        if selectedIndex != 0 {
            collectionView.performBatchUpdates({
                let indexPath = IndexPath(item: selectedIndex, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }, completion: nil)
        }
    }

    open override var prefersStatusBarHidden: Bool {
        return UbudConfig.shared.isStatusBarHidden
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return UbudConfig.shared.statusBarStyle
    }

    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func updateFocusState() {
        let isActive: Bool = (state == .active)
        UIView.animate(withDuration: 0.2) {
            self.closeButton.alpha = isActive ? 0 : 1.0
            self.state = isActive ? .inactive : .active
        }
    }
}

extension UbudController: UICollectionViewDataSource, UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? UbudCollectionPhotoCell else {
            fatalError("UbudCollectionPhotoCell is not found.")
        }
        if let image = images[indexPath.item].image {
            cell.configure(image: image)
        } else if let imageURL = images[indexPath.item].url {
            cell.loadImage(imageURL)
        }
        return cell
    }
}
