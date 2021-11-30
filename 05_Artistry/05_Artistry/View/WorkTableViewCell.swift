//
//  WorkTableViewCell.swift
//  05_Artistry
//
//  Created by rae on 2021/11/29.
//

import UIKit

class WorkTableViewCell: UITableViewCell {

    static let identifier = "WorkCell"
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
