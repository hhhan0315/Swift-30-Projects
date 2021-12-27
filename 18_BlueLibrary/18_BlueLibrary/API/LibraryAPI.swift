//
//  LibraryAPI.swift
//  18_BlueLibrary
//
//  Created by rae on 2021/12/27.
//

import Foundation

final class LibraryAPI {
    static let shared = LibraryAPI()
    
    private let persistencyManager = PersistencyManager()
    private let httpClient = HTTPClient()
    private let isOnline = false
    
    private init() { }
    
    func getAlbums() -> [Album] {
        return persistencyManager.getAlbums()
    }
    
    func addAlbum(_ album: Album, at index: Int) {
        persistencyManager.addAlbum(album, at: index)
        if isOnline {
//            httpClient.postRq
        }
    }
    
    func deleteAlbum(at index: Int) {
        persistencyManager.deleteAlbum(at: index)
        if isOnline {
            
        }
    }
}
