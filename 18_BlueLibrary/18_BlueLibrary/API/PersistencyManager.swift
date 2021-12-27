//
//  PersistencyManager.swift
//  18_BlueLibrary
//
//  Created by rae on 2021/12/27.
//

import Foundation

final class PersistencyManager {
    private var albums = [Album]()
    
    init() {
        let album1 = Album(title: "strawberry moon", artist: "아이유", genre: "K-Pop",
                           coverUrl: "https://w.namu.la/s/9557c5289aa8c0954156bca67d49d99802e764c8b1485612368baeeb793386197cbd7972af9e39e296eaa6b6e2f6cbf3f01d99809bd5c97d99475f9fb53c51c1b646cb3aedd6fdfd4b7900d9f0b63f3e8aa02c9669a01778c0d9a9c4ac073c06f34ad728ae2da02cd77be581e850bac9",
                           year: "2021")
        let album2 = Album(title: "에잇", artist: "아이유, SUGA", genre: "K-Pop",
                           coverUrl: "https://ww.namu.la/s/32ba23f114a74427117b1e89a43ac8aa6c7cb4e2c57ce4a0ea33bef0014370671d2e361cb8d8bfcbf3a51b041569e4791fc35c9ea87cecc443adeb1db3a4ab9ce03ba64b9569c201d48bc3b6e995fb2732d3199088b1e80f0310120d01f469d93ac04d219dd99eb3472198297f99c8aa",
                           year: "2020")
        let album3 = Album(title: "별의 조각", artist: "윤하", genre: "K-Pop",
                           coverUrl: "https://w.namu.la/s/4b75ef96a144c169b310a7d702b3efc2f10fcbeb65255a79ba44ef4853ec1a161255ba2ca4d4a45a7324f30a102f51eaa3f60057945040d36ebca22ce07a0ad6499292f067a2ea0fa336d07b05b88606d5aaa7e0effe3173409ab60378e2dede",
                           year: "2021")
        let album4 = Album(title: "느린 우체통", artist: "윤하", genre: "K-Pop",
                           coverUrl: "https://ww.namu.la/s/ac5504adb9eb43177a7f94b7a33a756e4213cf131748323418b4430d3a62a3f6a8edc1cb9b2281940fd466f0783aca1939bf44910aa52e422b83761de910aa08e5ba776d645e6bfe4315b3564a053882905d40bb5a13fab44764d903ae4fad33",
                           year: "2017")
        let album5 = Album(title: "Sunflower", artist: "Post Malone, Swae Lee", genre: "Pop",
                           coverUrl: "https://w.namu.la/s/d4dee0f088e2d8c182cd35b3730d38cbfafbbfd3b6d542df95ced875c8a4b76a94e0cfa904b96f5732a68e985335f52ba702f53f0249b69697474959c66371e4f32500d4a9403115fb4a9bdbdd9999a07e2346a428a2a8a829a265b7b86c7485",
                           year: "2018")
        let album6 = Album(title: "Waving Through A Window", artist: "Evan", genre: "Pop",
                           coverUrl: "https://ww.namu.la/s/a93b297550f2872a0e35e5326af481b4e36a73c6ea6559e86523df343fbc46aeb2ed740ff9cf9f0e163687486d1eec3a2587ffe4d2100e01ad791abf640c358ae28a4b696e66551851c96996cb9fa9cab2cc651e62b71146fa3648e14f055b0a",
                           year: "2021")
        
        albums = [album1, album2, album3, album4, album5, album6]
    }
    
    func getAlbums() -> [Album] {
        return albums
    }
    
    func addAlbum(_ album: Album, at index: Int) {
        if albums.count >= index {
            albums.insert(album, at: index)
        } else {
            albums.append(album)
        }
    }
    
    func deleteAlbum(at index: Int) {
        albums.remove(at: index)
    }
}
