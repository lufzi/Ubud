//
//  UbudPresentationController.swift
//  Ubud
//
//  Created by Luqman Fauzi on 24/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

internal class UbudPresentationController: UIPresentationController {

    init(presenter: UIViewController, presented: UIViewController) {
        super.init(presentedViewController: presented, presenting: presenter)
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            // self.maskView.alpha = 1
        }, completion: nil)
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            // self.maskView.alpha = 0
        }, completion: { _ in
            // self.currentHiddenView?.isHidden = false
        })
    }
}
