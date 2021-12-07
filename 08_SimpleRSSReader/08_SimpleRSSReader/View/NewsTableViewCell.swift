//
//  NewsTableViewCell.swift
//  08_SimpleRSSReader
//
//  Created by rae on 2021/12/06.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
