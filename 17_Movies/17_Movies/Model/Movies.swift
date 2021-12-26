//
//  Movies.swift
//  17_Movies
//
//  Created by rae on 2021/12/22.
//

import Foundation

struct Movies: Codable {
    let page: Int
    let results: [Results]
    let totalResults: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
