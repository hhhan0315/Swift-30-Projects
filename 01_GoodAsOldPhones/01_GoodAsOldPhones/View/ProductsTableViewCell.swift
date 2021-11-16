//
//  ProductsTableViewCell.swift
//  01_GoodAsOldPhones
//
//  Created by rae on 2021/11/16.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    
    static let identifier = "ProductsCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
