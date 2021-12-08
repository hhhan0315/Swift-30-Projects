//
//  PhotoDetailViewController.swift
//  09_PhotoScroll
//
//  Created by rae on 2021/12/07.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var photoImageName: String? {
        didSet {
            guard let photoImageName = photoImageName else { return }
            let image = UIImage(named: photoImageName)
            let width = image?.size.width ?? 0
            let height = image?.size.height ?? 0
            mainImageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            mainImageView.image = image
        }
    }
    
    private var topConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        autoLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainImageView)
    }
    
    private func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
        
        topConstraint = mainImageView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        leadingConstraint = mainImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        trailingConstraint = mainImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        bottomConstraint = mainImageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)

        topConstraint?.isActive = true
        leadingConstraint?.isActive = true
        trailingConstraint?.isActive = true
        bottomConstraint?.isActive = true
    }

    private func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / mainImageView.bounds.width
        let heightScale = size.height / mainImageView.bounds.height
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    // 이미지 가운데로
    private func updateConstraintsForSize(_ size: CGSize) {
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let bottomPadding = view.window?.safeAreaInsets.bottom ?? 0
        let height = size.height - mainImageView.frame.height - statusBarHeight - navigationBarHeight - bottomPadding
        
        let yOffset = max(0, height / 2)
        topConstraint?.constant = yOffset
        bottomConstraint?.constant = yOffset
        
        let xOffset = max(0, (size.width - mainImageView.frame.width) / 2)
        leadingConstraint?.constant = xOffset
        trailingConstraint?.constant = xOffset
        
        view.layoutIfNeeded()
    }
}

extension PhotoDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mainImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
}
