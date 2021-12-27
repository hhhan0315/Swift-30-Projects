//
//  Album.swift
//  18_BlueLibrary
//
//  Created by rae on 2021/12/27.
//

import Foundation

struct Album {
    var title: String
    var artist: String
    var genre: String
    var coverUrl: String
    var year: String
}

typealias AlbumData = (title: String, value: String)

extension Album {
    var tableRepresentation: [AlbumData] {
        return [
            ("Artist", artist),
            ("Title", title),
            ("Genre", genre),
            ("Year", year),
        ]
    }
}
