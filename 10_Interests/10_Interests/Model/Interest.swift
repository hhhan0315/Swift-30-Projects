//
//  Interest.swift
//  10_Interests
//
//  Created by rae on 2021/12/11.
//

import UIKit

class Interest {
    var image: UIImage!
    var title = ""
    
    init(image: UIImage, title: String) {
        self.image = image
        self.title = title
    }
}

extension Interest {
    static let testData: [Interest] = [
        Interest(image: UIImage(named: "r1")!, title: "We Love Traveling Around The World"),
        Interest(image: UIImage(named: "r2")!, title: "Reading a book"),
        Interest(image: UIImage(named: "r3")!, title: "Swift"),
        Interest(image: UIImage(named: "r4")!, title: "iOS"),
        Interest(image: UIImage(named: "r5")!, title: "Soccer"),
        Interest(image: UIImage(named: "r6")!, title: "Game"),
    ]
}
