//
//  UsViewController.swift
//  01_GoodAsOldPhones
//
//  Created by rae on 2021/11/16.
//

import UIKit

class UsViewController: UIViewController {
    
    let topBottomConstant: CGFloat = 50
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "header-contact")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let aboutUsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "About Us"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "Good as Old Phones return the phones of yesteryear back to ther original glory and then gets them into the hands* of those who appreciate them most:\n\nWhether you are looking for a turn-of-the-century wall set or a Zack Morris Special, we've got you covered. Give us a ring, and we will get you connected."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "*Hands-free phones available"
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contactTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Contact"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailStackView: UIStackView = {
        let stackView = UIStackView()
        let imageView = UIImageView(image: UIImage(named: "icon-about-email"))
        let label = UILabel()
        label.text = "good-as-old@example.com"
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        stackView.spacing = 20
        return stackView
    }()
    
    private let phoneStackView: UIStackView = {
        let stackView = UIStackView()
        let imageView = UIImageView(image: UIImage(named: "icon-about-phone"))
        let label = UILabel()
        label.text = "412-888-9028"
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        stackView.spacing = 20
        return stackView
    }()

    private let websiteStackView: UIStackView = {
        let stackView = UIStackView()
        let imageView = UIImageView(image: UIImage(named: "icon-about-website"))
        let label = UILabel()
        label.text = "www.example.com"
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailStackView, phoneStackView, websiteStackView])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        setupViews()
    }

    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1000)
        ])
    }
    
    func setupViews() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
        ])
        
        contentView.addSubview(aboutUsTitleLabel)
        NSLayoutConstraint.activate([
            aboutUsTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            aboutUsTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: topBottomConstant),
        ])
        
        contentView.addSubview(contentLabel)
        NSLayoutConstraint.activate([
            contentLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4),
            contentLabel.topAnchor.constraint(equalTo: aboutUsTitleLabel.bottomAnchor, constant: topBottomConstant),
        ])
        
        contentView.addSubview(commentLabel)
        NSLayoutConstraint.activate([
            commentLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            commentLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4),
            commentLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: topBottomConstant),
        ])
        
        contentView.addSubview(contactTitleLabel)
        NSLayoutConstraint.activate([
            contactTitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contactTitleLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: topBottomConstant),
        ])
        
        contentView.addSubview(infoStackView)
        NSLayoutConstraint.activate([
            infoStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            infoStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4),
            infoStackView.topAnchor.constraint(equalTo: contactTitleLabel.bottomAnchor, constant: topBottomConstant),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

}
