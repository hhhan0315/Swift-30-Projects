//
//  DiscoverViewController.swift
//  15_SnapchatMenu
//
//  Created by rae on 2021/12/21.
//

import UIKit

class DiscoverViewController: UIViewController {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Discover")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
    }

}
