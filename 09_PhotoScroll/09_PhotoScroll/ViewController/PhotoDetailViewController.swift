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
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }

    private func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / mainImageView.bounds.width
        let heightScale = size.height / mainImageView.bounds.height
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
}

extension PhotoDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mainImageView
    }
}
