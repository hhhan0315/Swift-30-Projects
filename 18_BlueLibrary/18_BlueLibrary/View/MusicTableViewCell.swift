//
//  MusicTableViewCell.swift
//  18_BlueLibrary
//
//  Created by rae on 2021/12/27.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    static let identifier = "MusicCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
