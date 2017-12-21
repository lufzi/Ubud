//
//  UbudTopContainerView.swift
//  Ubud
//
//  Created by Luqman Fauzi on 03/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

public final class UbudTopContainerView: UIView {

    // MARK: - Private Properties

    private var dismissContent: DismissButtonContent = .text("")

    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(self.didTapDismissButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Public Property

    public var dismissButtonDidTap: (() -> Void)?

    public init(dismissContent: DismissButtonContent) {
        super.init(frame: .zero)
        self.dismissContent = dismissContent
        alpha = 0
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        addSubview(dismissButton)
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: topAnchor),
            dismissButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.0),
            dismissButton.widthAnchor.constraint(equalTo: heightAnchor)
        ])
        configureDismissButton(content: dismissContent)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private Methods

    @objc private func didTapDismissButton() {
        dismissButtonDidTap?()
    }

    // MARK: - Public Methods

    public func configureDismissButton(content: DismissButtonContent) {
        switch content {
        case .text(let text):
            dismissButton.setImage(nil, for: .normal)
            dismissButton.setTitle(text, for: .normal)
        case .image(let image):
            dismissButton.setTitle(nil, for: .normal)
            dismissButton.setImage(image, for: .normal)
        }
    }
}
