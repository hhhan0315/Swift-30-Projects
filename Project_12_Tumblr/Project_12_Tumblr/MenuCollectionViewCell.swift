//
//  MenuCollectionViewCell.swift
//  Project_12_Tumblr
//
//  Created by rae on 2021/12/16.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MenuCollectionCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()
    
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
        contentView.addSubview(label)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: label.topAnchor),
            
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
