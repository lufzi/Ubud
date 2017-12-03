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

    // MARK: - Private Properties

    private lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UbudCollectionFlowLayout(size: UIScreen.main.bounds.size)
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

    private lazy var animator: UbudTransitionAnimator = {
        return UbudTransitionAnimator(duration: 0.5)
    }()

    private weak var displayDelegate: UbudControllerDisplayDelegate?
    private weak var delegate: UbudControllerDelegate!
    private var presenting: UIViewController!
    private var images: [UbudImage]!
    private var currentIndex: Int = 0
    private var selectedIndex: Int = 0
    private var selectedImage: UIImageView?
    private var state: FocusState = .active

    private init(presentedBy presenting: UIViewController, delegate: UbudControllerDelegate, displayDelegate: UbudControllerDisplayDelegate?) {
        self.presenting = presenting
        self.delegate = delegate
        self.displayDelegate = displayDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Public Methods

    open class func show(presentedBy presenting: UIViewController, delegate: UbudControllerDelegate, displayDelegate: UbudControllerDisplayDelegate? = nil, atIndex index: Int) {
        let controller = UbudController(
            presentedBy: presenting,
            delegate: delegate,
            displayDelegate: displayDelegate
        )
        controller.present(selectedIndex: index)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        [collectionView, topContainerView].forEach { view.addSubview($0) }
        topContainerView.addSubview(closeButton)
        collectionView.addGestureRecognizer(tapGesture)
    }

    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.view.alpha = (size.width > size.height) ? 0.25 : 0.55
        }, completion: nil)
    }

    open override var prefersStatusBarHidden: Bool {
        return displayDelegate?.isStatusBarHidden() ?? false
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return displayDelegate?.statusBarStyle() ?? .default
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

    private func present(selectedIndex: Int) {
        self.selectedIndex = selectedIndex
        self.currentIndex = selectedIndex
//        modalPresentationStyle = .custom
//        transitioningDelegate = self
        presenting.present(self, animated: true, completion: nil)
    }
}

extension UbudController: UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - UICollectionViewDataSource

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.numberOfOPhotos(in: self) ?? 0
    }

    // MARK: - UICollectionViewDelegate

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? UbudCollectionPhotoCell else {
            fatalError("UbudCollectionPhotoCell is not found.")
        }
        if let imageURL = delegate?.photoURLForItem(in: self, atIndex: indexPath.item) {
            cell.loadImage(imageURL)
        }
        if let image = delegate?.photoImageForItem(in: self, atIndex: indexPath.item) {
            cell.configure(image: image)
        }
        return cell
    }
}

extension UbudController: UIViewControllerTransitioningDelegate {

    // MARK: - UIViewControllerTransitioningDelegate

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.originFrame = selectedImage?.superview?.convert(selectedImage?.frame ?? .zero, to: nil) ?? .zero
        animator.isPresenting = true
        selectedImage?.isHidden = true
        return animator
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isPresenting = false
        return animator
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        guard let presented = presenting else { return nil }
        return UbudPresentationController(presenter: presented, presented: presented)
    }
}
