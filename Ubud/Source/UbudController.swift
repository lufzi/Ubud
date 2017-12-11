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

    private enum FocusState: CGFloat {
        case active = 1.0
        case inactive = 0
    }

    // MARK: - Private Properties

    private lazy var collectionView: UICollectionView = { [unowned self] in
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(UbudCollectionPhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.addGestureRecognizer(self.tapGesture)
        return collectionView
    }()

    private lazy var topContainerView: UbudTopContainerView = { [unowned self] in
        let view = UbudTopContainerView(dismissContent: .text("Dismiss"))
        view.dismissButtonDidTap = self.dismissView
        return view
    }()

    private lazy var bottomContainerView: UbudPaginationIndicatorView = { [unowned self] in
        let view = UbudPaginationIndicatorView()
        return view
    }()

    private lazy var tapGesture: UITapGestureRecognizer = { [unowned self] in
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapContent))
        return gesture
    }()

    private lazy var animator: UbudTransitionAnimator = {
        return UbudTransitionAnimator(duration: 0.5)
    }()

    private weak var delegate: UbudControllerDelegate?
    private weak var paginationDelegate: UbudControllerPaginationDelegate?
    private weak var dataSource: UbudControllerDataSource!
    private var presenting: UIViewController!
    private var currentIndex: Int = 0
    private var selectedIndex: Int = 0
    private var selectedImage: UIImageView?
    private var focusState: FocusState = .inactive

    private init(presentedBy presenting: UIViewController, dataSource: UbudControllerDataSource, delegate: UbudControllerDelegate?, paginationDelegate: UbudControllerPaginationDelegate?) {
        self.presenting = presenting
        self.dataSource = dataSource
        self.delegate = delegate
        self.paginationDelegate = paginationDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Public Methods

    open class func show(presentedBy presenting: UIViewController, dataSource: UbudControllerDataSource, delegate: UbudControllerDelegate? = nil, paginationDelegate: UbudControllerPaginationDelegate? = nil, atIndex index: Int) {

        let controller = UbudController(
            presentedBy: presenting,
            dataSource: dataSource,
            delegate: delegate,
            paginationDelegate: paginationDelegate
        )
        controller.present(selectedIndex: index)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }

    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.view.alpha = (size.width > size.height) ? 0.25 : 0.55
        }, completion: nil)
    }

    open override var prefersStatusBarHidden: Bool {
        return delegate?.statusBarHidden(in: self) ?? false
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return delegate?.statusBarStyle(in: self) ?? .lightContent
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //// Setup new collection flow layout after the VC is being displayed.
        let layout = UbudCollectionFlowLayout(collectionViewSize: collectionView.bounds.size)
        collectionView.setCollectionViewLayout(layout, animated: false)
        /// Update current content to a content of selected index.
        updateContentCellAtSelectedIndex()
        configurePaginationIndicator(isInitialLoad: true, index: currentIndex)
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(collectionView)
        view.addSubview(topContainerView)
        setupConstraints()
    }

    private func setupConstraints() {
        let topContainerViewTopAnchor: NSLayoutYAxisAnchor
        let topContainerViewLeadingAnchor: NSLayoutXAxisAnchor
        let topContainerViewTrailingAnchor: NSLayoutXAxisAnchor
        let collectionViewTopAnchor: NSLayoutYAxisAnchor
        let collectionViewBottomAnchor: NSLayoutYAxisAnchor

        if #available(iOS 11.0, *) {
            topContainerViewTopAnchor = view.safeAreaLayoutGuide.topAnchor
            topContainerViewLeadingAnchor = view.safeAreaLayoutGuide.leadingAnchor
            topContainerViewTrailingAnchor = view.safeAreaLayoutGuide.trailingAnchor
            collectionViewTopAnchor = view.safeAreaLayoutGuide.topAnchor
            collectionViewBottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            topContainerViewTopAnchor = view.topAnchor
            topContainerViewLeadingAnchor = view.leadingAnchor
            topContainerViewTrailingAnchor = view.trailingAnchor
            collectionViewTopAnchor = view.topAnchor
            collectionViewBottomAnchor = view.bottomAnchor
        }

        NSLayoutConstraint.activate([
            topContainerView.heightAnchor.constraint(equalToConstant: 70.0),
            topContainerView.topAnchor.constraint(equalTo: topContainerViewTopAnchor),
            topContainerView.leadingAnchor.constraint(equalTo: topContainerViewLeadingAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: topContainerViewTrailingAnchor)
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: collectionViewTopAnchor),
            collectionView.leadingAnchor.constraint(equalTo: topContainerViewLeadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: topContainerViewTrailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: collectionViewBottomAnchor)
        ])

        if paginationDelegate != nil {
            view.addSubview(bottomContainerView)
            NSLayoutConstraint.activate([
                bottomContainerView.heightAnchor.constraint(equalToConstant: 50.0),
                bottomContainerView.leadingAnchor.constraint(equalTo: topContainerViewLeadingAnchor),
                bottomContainerView.trailingAnchor.constraint(equalTo: topContainerViewTrailingAnchor),
                bottomContainerView.bottomAnchor.constraint(equalTo: collectionViewBottomAnchor)
            ])
        }

        /// Check if delegate provide custom dismiss button content
        if let dismissContent = delegate?.dismissButtonContent(in: self) {
            topContainerView.configureDismissButton(content: dismissContent)
        }
    }

    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapContent() {
        updateFocusState()
    }

    @objc private func updateFocusState() {
        let updatedState: FocusState = (focusState == .active) ? .inactive : .active
        focusState = updatedState
        UIView.animate(withDuration: 0.2) {
            /// Update alpha of container view
            self.topContainerView.alpha = updatedState.rawValue
        }
    }

    private func updateContentCellAtSelectedIndex() {
        if selectedIndex != 0 {
            collectionView.performBatchUpdates({
                let indexPath = IndexPath(item: selectedIndex, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }, completion: nil)
        }
    }

    private func configurePaginationIndicator(isInitialLoad: Bool = false, index: Int) {
        guard paginationDelegate != nil else { return }
        let totalPages = dataSource.numberOfOPhotos(in: self)
        /// Call pagination delegate and setup the pagination style
        if let paginationStyle = paginationDelegate?.imagesPaginationStyle(in: self) {
            bottomContainerView.configure(
                isInitialLoad: isInitialLoad,
                currentIndex: index,
                totalPages: totalPages,
                style: paginationStyle
            )
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
        return dataSource?.numberOfOPhotos(in: self) ?? 0
    }

    // MARK: - UICollectionViewDelegate

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? UbudCollectionPhotoCell
        else {
            fatalError("UbudCollectionPhotoCell is not found.")
        }
        /// Configure image content
        switch dataSource.imageSourceForItem(in: self, atIndex: indexPath.item) {
        case .image(let image):
            cell.configureImage(image)
        case .url(let url):
            cell.configureImage(url)
        }
        return cell
    }

    // MARK: - UIScrollViewDelegate

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let width = scrollView.bounds.size.width

        /// Set current index
        let targetIndex = Int(ceil(x/width))
        let isPageChanging = (currentIndex != targetIndex)
        guard isPageChanging else { return }
        currentIndex = targetIndex

        /// Call pagination delegate upon page did change
        paginationDelegate?.imagesPaginationDidChange(in: self, atIndex: currentIndex)
        configurePaginationIndicator(index: currentIndex)
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
