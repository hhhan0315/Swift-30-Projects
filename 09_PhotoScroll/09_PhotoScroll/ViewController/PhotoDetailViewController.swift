//
//  PhotoDetailViewController.swift
//  09_PhotoScroll
//
//  Created by rae on 2021/12/07.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var photoImageName: String?
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        guard let imageName = photoImageName else { return imageView }
        imageView.image = UIImage(named: imageName)
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        autoLayout()
    }
    
    private func addViews() {
        view.addSubview(mainImageView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: view.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}
