//
//  PhotoMainCollectionViewCell.swift
//  09_PhotoScroll
//
//  Created by rae on 2021/12/07.
//

import UIKit

class PhotoMainCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoMainCollectionViewCell"
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addContentViews()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentViews() {
        contentView.addSubview(mainImageView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
