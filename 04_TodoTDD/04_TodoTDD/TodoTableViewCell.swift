//
//  TodoTableViewCell.swift
//  04_TodoTDD
//
//  Created by rae on 2021/11/24.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    static let identifier = "TodoCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(timeLabel)
    }
    
    private func autoLayout() {
        let multiplier: CGFloat = 1/3
        let height: CGFloat = 100
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier),
            titleLabel.heightAnchor.constraint(equalToConstant: height),
            
            addressLabel.topAnchor.constraint(equalTo: self.topAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            addressLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier),
            addressLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor),
            timeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier),
            timeLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
        ])
    }
}
