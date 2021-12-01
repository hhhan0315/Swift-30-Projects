//
//  ArtistTableViewCell.swift
//  05_Artistry
//
//  Created by rae on 2021/11/29.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {

    static let identifier = "ArtistCell"
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
