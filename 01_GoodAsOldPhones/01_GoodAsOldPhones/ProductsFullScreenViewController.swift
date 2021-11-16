//
//  ProductsFullScreenViewController.swift
//  01_GoodAsOldPhones
//
//  Created by rae on 2021/11/16.
//

import UIKit

class ProductsFullScreenViewController: UIViewController {
    
    private var titleName: String?
    private var imageName: String?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        guard let imageName = imageName else {
            return UIImageView()
        }
        imageView.image = UIImage(named: imageName)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleName
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "button-addtocart"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureImageConstraints()
        configureLabelConstraints()
        configureButtonConstraints()
    }
    
    func configureNames(title: String, imageName: String) {
        self.titleName = title
        self.imageName = imageName
    }
    
    func configureImageConstraints() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureLabelConstraints() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60)
        ])
    }
    
    func configureButtonConstraints() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30)
        ])
    }

}
