//
//  Artist.swift
//  05_Artistry
//
//  Created by rae on 2021/11/29.
//

import Foundation

struct Artist: Codable {
    let name: String
    let bio: String
    let image: String
    var works: [Work]
}
