//
//  LibraryAPI.swift
//  18_BlueLibrary
//
//  Created by rae on 2021/12/27.
//

import UIKit

final class LibraryAPI {
    static let shared = LibraryAPI()
    
    private let persistencyManager = PersistencyManager()
    private let httpClient = HTTPClient()
    private let isOnline = false
    
    private init() {
        // AlbumView가 Notification Center에 알림
        // LibraryAPI가 해당 알림에 대한 관찰자로 등록
        // LibraryAPI가 downloadImage(with:) 호출
        NotificationCenter.default.addObserver(self, selector: #selector(downloadImage(_:)), name: .BLDownloadImage, object: nil)
    }
    
    func getAlbums() -> [Album] {
        return persistencyManager.getAlbums()
    }
//    
//    func addAlbum(_ album: Album, at index: Int) {
//        persistencyManager.addAlbum(album, at: index)
//        if isOnline {
////            httpClient.postRq
//        }
//    }
//    
//    func deleteAlbum(at index: Int) {
//        persistencyManager.deleteAlbum(at: index)
//        if isOnline {
//            
//        }
//    }
    
    @objc func downloadImage(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let imageView = userInfo["imageView"] as? UIImageView,
              let coverUrl = userInfo["coverUrl"] as? String,
              let filename = URL(string: coverUrl)?.lastPathComponent else {
            return
        }
        
        if let savedImage = persistencyManager.getImage(with: filename) {
            imageView.image = savedImage
            return
        }
        
        DispatchQueue.global().async {
            let downloadedImage = self.httpClient.downloadImage(coverUrl)
            DispatchQueue.main.async {
                imageView.image = downloadedImage
                self.persistencyManager.saveImage(downloadedImage, filename: filename)
            }
        }
    }
}
