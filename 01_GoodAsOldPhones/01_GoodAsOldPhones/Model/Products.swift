//
//  Products.swift
//  01_GoodAsOldPhones
//
//  Created by rae on 2021/11/16.
//

import Foundation

struct Products {
    var imageName: String
    var title: String
    var fullScreenImageName: String
}

extension Products {
    static var testData = [
        Products(imageName: "image-cell1", title: "1907 Wall Set", fullScreenImageName: "phone-fullscreen1"),
        Products(imageName: "image-cell2", title: "1921 Dial Phone", fullScreenImageName: "phone-fullscreen2"),
        Products(imageName: "image-cell3", title: "1937 Dark Set", fullScreenImageName: "phone-fullscreen3"),
        Products(imageName: "image-cell4", title: "1984 Moto Portable", fullScreenImageName: "phone-fullscreen4")
    ]
}
