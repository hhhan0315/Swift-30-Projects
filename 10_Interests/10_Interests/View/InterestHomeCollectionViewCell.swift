//
//  InterestHomeCollectionViewCell.swift
//  10_Interests
//
//  Created by rae on 2021/12/10.
//

import UIKit

class InterestHomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "InterestHomeCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "test"
        return label
    }()
    
    var interest: Interest! {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    
    private func addViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(visualEffectView)
        visualEffectView.contentView.addSubview(label)
    }
    
    private func autoLayout() {
        let heightConstant = contentView.frame.height / 4
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            visualEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            visualEffectView.heightAnchor.constraint(equalToConstant: heightConstant),
            
            label.topAnchor.constraint(equalTo: visualEffectView.topAnchor),
            label.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor, constant: 16.0),
            label.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor, constant: -16.0),
            label.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor),
        ])
    }
    
    private func updateUI() {
        imageView.image = interest.image
        label.text = interest.title
    }
}
