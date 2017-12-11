//
//  ExampleGalleryViewController.swift
//  Ubud-Example
//
//  Created by Luqman Fauzi on 11/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

final class ExampleGalleryViewController: UIViewController {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Local Images", "URL Images"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.updateChildViewController), for: .valueChanged)
        return segmentedControl
    }()

    private lazy var localResourceViewController: LocalResourceViewController = {
        return LocalResourceViewController(example: self.example)
    }()

    private lazy var remoteResourceViewController: RemoteResourceViewController = {
        return RemoteResourceViewController(example: self.example)
    }()

    private var example: Example!

    public init(example: Example) {
        super.init(nibName: nil, bundle: nil)
        self.example = example
        view.backgroundColor = .white
        title = example.rawValue
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.titleView = segmentedControl
        updateChildViewController()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    @objc private func updateChildViewController() {
        if segmentedControl.selectedSegmentIndex == 0 {
            /// Update childVC to local local VC
            remoteResourceViewController.willMove(toParentViewController: nil)
            remoteResourceViewController.view.removeFromSuperview()
            remoteResourceViewController.removeFromParentViewController()
            addChildViewController(localResourceViewController)
            localResourceViewController.view.frame = containerView.frame
            containerView.addSubview(localResourceViewController.view)
            localResourceViewController.didMove(toParentViewController: self)
        } else {
            /// Update childVC to remote resource VC
            localResourceViewController.willMove(toParentViewController: nil)
            localResourceViewController.view.removeFromSuperview()
            localResourceViewController.removeFromParentViewController()
            addChildViewController(remoteResourceViewController)
            remoteResourceViewController.view.frame = containerView.frame
            containerView.addSubview(remoteResourceViewController.view)
            remoteResourceViewController.didMove(toParentViewController: self)
        }
    }
}
