//
//  TransitionManager.swift
//  Project_12_Tumblr
//
//  Created by rae on 2021/12/16.
//

import UIKit

class TransitionManager: NSObject {
    enum TransitionMode {
        case present, dismiss
    }
    
    private var duration = 1.0
    private var transitionMode: TransitionMode = .present
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 뷰를 담을 수 있는 전체 틀
        let containerView = transitionContext.containerView
        
        // 앞으로 사라질 뷰
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            transitionContext.completeTransition(false)
            return
        }

        // 앞으로 나타날 뷰
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        var menuViewController: MenuViewController
        
        switch transitionMode {
        case .present:
            menuViewController = toViewController as! MenuViewController
        case .dismiss:
            menuViewController = fromViewController as! MenuViewController
        }
        
        // 미리 준비
        if self.transitionMode == .present {
            dismissMenuController(menuViewController)
        }
        
        guard let menuView = menuViewController.view else { return }
        containerView.addSubview(menuView)

        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: []) {
            if self.transitionMode == .present {
                self.presentMenuController(menuViewController)
            } else if self.transitionMode == .dismiss {
                self.dismissMenuController(menuViewController)
            }
        } completion: { _ in
            transitionContext.completeTransition(true)
        }
    }
    
    private func presentMenuController(_ menuViewController: MenuViewController) {
        menuViewController.view.alpha = 1
    }
    
    private func dismissMenuController(_ menuViewController: MenuViewController) {
        menuViewController.view.alpha = 0
        let startOffSet: CGFloat = 300
        let collectionViewCells = menuViewController.collectionView.visibleCells
        for index in 0..<collectionViewCells.count {
            if index % 2 == 0 {
                let offset = startOffSet / CGFloat(index / 2 + 1)
                collectionViewCells[index].transform = CGAffineTransform(translationX: -offset, y: 0)
            } else {
                let offset = startOffSet / CGFloat(index / 2 + 1)
                collectionViewCells[index].transform = CGAffineTransform(translationX: offset, y: 0)
            }
        }
    }
}

extension TransitionManager: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionMode = .present
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionMode = .dismiss
        return self
    }
}
