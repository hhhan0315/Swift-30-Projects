//
//  Work.swift
//  05_Artistry
//
//  Created by rae on 2021/11/29.
//

import Foundation

struct Work: Codable {
    let title: String
    let image: String
    let info: String
    var expanded: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        info = try container.decode(String.self, forKey: .info)
        expanded = (try? container.decodeIfPresent(Bool.self, forKey: .expanded)) ?? false
    }
}
