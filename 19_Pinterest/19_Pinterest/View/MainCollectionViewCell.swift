//
//  MainCollectionViewCell.swift
//  19_Pinterest
//
//  Created by rae on 2021/12/29.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .darkGray
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .darkGray
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    var photo: Photo? {
        didSet {
            if let photo = photo {
                imageView.image = photo.image
                captionLabel.text = photo.caption
                commentLabel.text = photo.comment
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addContentViews()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addContentViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(captionLabel)
        contentView.addSubview(commentLabel)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            captionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            captionLabel.bottomAnchor.constraint(equalTo: commentLabel.topAnchor),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
