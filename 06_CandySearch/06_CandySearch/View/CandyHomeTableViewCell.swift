//
//  CandyHomeTableViewCell.swift
//  06_CandySearch
//
//  Created by rae on 2021/12/03.
//

import UIKit

class CandyHomeTableViewCell: UITableViewCell {

    static let identifier = "CandyHomeCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
