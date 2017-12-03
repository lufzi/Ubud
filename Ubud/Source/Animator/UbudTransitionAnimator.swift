//
//  UbudTransitionAnimator.swift
//  Ubud
//
//  Created by Luqman Fauzi on 24/10/2017.
//  Copyright © 2017 Luqman Fauzi. All rights reserved.
//

import UIKit

internal class UbudTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var duration: TimeInterval
    var isPresenting: Bool = true
    var originFrame: CGRect = .zero

    init(duration: TimeInterval) {
        self.duration = duration
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.viewController(forKey: .to)!.view!
        let herbView = isPresenting ? toView : transitionContext.view(forKey: .from)!

        let initialFrame = isPresenting ? originFrame : herbView.frame
        let finalFrame = isPresenting ? herbView.frame : originFrame

        let xScaleFactor = isPresenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width

        let yScaleFactor = isPresenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height

        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)

        if isPresenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
            herbView.clipsToBounds = true
        }

        containerView.addSubview(toView)
        containerView.bringSubview(toFront: herbView)

        UIView.animate(withDuration: duration, animations: {
            herbView.transform = self.isPresenting ? CGAffineTransform.identity : scaleTransform
            herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }, completion: { _ in
            transitionContext.completeTransition(!(transitionContext.transitionWasCancelled))
        })
    }
}
