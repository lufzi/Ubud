//
//  UbudPaginationIndicatorView.swift
//  Ubud
//
//  Created by Luqman Fauzi on 11/12/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

internal final class UbudPaginationIndicatorView: UIView {

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    public init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: topAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func configure(isInitialLoad: Bool = false, currentIndex: Int, totalPages: Int, style: ImagesPaginationStyle) {
        switch style {
        case .textIndicator:
            pageControl.isHidden = true
            textLabel.text = "\(currentIndex + 1)/\(totalPages)"
        case .dotIndicator:
            textLabel.isHidden = true
            pageControl.numberOfPages = totalPages
            pageControl.currentPage = currentIndex
            if isInitialLoad {
                switch totalPages {
                case 0...22:
                    return
                case 22...25:
                    pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                case 26...30:
                    pageControl.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                default:
                    pageControl.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }
            }
        }
    }
}
