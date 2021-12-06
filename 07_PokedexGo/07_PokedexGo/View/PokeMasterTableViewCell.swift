//
//  PokeMasterTableViewCell.swift
//  07_PokedexGo
//
//  Created by rae on 2021/12/05.
//

import UIKit

class PokeMasterTableViewCell: UITableViewCell {
    
    static let identifier = "PokeMasterCell"
    
    var numLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addContentViews()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
    private func addContentViews() {
        contentView.addSubview(numLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(mainImageView)
    }
    
    private func autoLayout() {
        NSLayoutConstraint.activate([            
            numLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            numLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20),
            
            nameLabel.widthAnchor.constraint(equalTo: numLabel.widthAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 20),
            
            mainImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            mainImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            mainImageView.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: -16.0),
            mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0),
        ])
    }

}
