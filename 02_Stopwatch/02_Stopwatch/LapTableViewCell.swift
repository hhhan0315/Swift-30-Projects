//
//  LapTableViewCell.swift
//  02_Stopwatch
//
//  Created by rae on 2021/11/21.
//

import UIKit

class LapTableViewCell: UITableViewCell {

    static let identifier = "LapCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
