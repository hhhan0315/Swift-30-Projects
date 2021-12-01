//
//  WorkTableViewCell.swift
//  05_Artistry
//
//  Created by rae on 2021/11/29.
//

import UIKit

class WorkTableViewCell: UITableViewCell {

    static let identifier = "WorkCell"
        
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
