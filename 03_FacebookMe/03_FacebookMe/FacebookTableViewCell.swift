//
//  FacebookTableViewCell.swift
//  03_FacebookMe
//
//  Created by rae on 2021/11/22.
//

import UIKit

class FacebookTableViewCell: UITableViewCell {
    
    static let identifier = "FacebookCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
