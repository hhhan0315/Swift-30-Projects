//
//  HomeViewController.swift
//  15_SnapchatMenu
//
//  Created by rae on 2021/12/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        addViews()
        addChildViewController()
    }
    
    private func addViews() {
        view.addSubview(scrollView)
    }

    private func addChildViewController() {
        let chatVC = ChatViewController()
        let snapVC = SnapViewController()
        let storiesVC = StoriesViewController()
        let discoverVC = DiscoverViewController()
        
        self.addChild(chatVC)
        self.addChild(snapVC)
        self.addChild(storiesVC)
        self.addChild(discoverVC)
        
        self.scrollView.addSubview(chatVC.view)
        self.scrollView.addSubview(snapVC.view)
        self.scrollView.addSubview(storiesVC.view)
        self.scrollView.addSubview(discoverVC.view)
        
        chatVC.didMove(toParent: self)
        snapVC.didMove(toParent: self)
        storiesVC.didMove(toParent: self)
        discoverVC.didMove(toParent: self)

        changeOriginX(view: snapVC.view, originX: self.view.frame.width)
        changeOriginX(view: storiesVC.view, originX: self.view.frame.width * 2)
        changeOriginX(view: discoverVC.view, originX: self.view.frame.width * 3)

        self.scrollView.contentSize = CGSize(width: view.frame.width * 4, height: view.frame.height)
        self.scrollView.contentOffset = CGPoint(x: view.frame.width, y: 0)
    }
    
    private func changeOriginX(view: UIView, originX: CGFloat) {
        var frame = view.frame
        frame.origin.x = originX
        view.frame = frame
    }
}
