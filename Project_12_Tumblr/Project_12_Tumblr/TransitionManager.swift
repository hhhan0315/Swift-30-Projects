//
//  TransitionManager.swift
//  Project_12_Tumblr
//
//  Created by rae on 2021/12/16.
//

import UIKit

class TransitionManager: NSObject {
    
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        <#code#>
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        <#code#>
//    }
}

extension TransitionManager: UIViewControllerTransitioningDelegate {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let container = transitionContext.containerView
//        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
//        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
//        
//        let offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
//        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
//        
//        toView?.transform = offScreenRight
    }
}
