//
//  NewsTableViewCell.swift
//  08_SimpleRSSReader
//
//  Created by rae on 2021/12/06.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableCell"

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel! {
        didSet {
            contentsLabel.numberOfLines = 2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
