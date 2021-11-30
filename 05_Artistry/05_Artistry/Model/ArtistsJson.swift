//
//  ArtistsJson.swift
//  05_Artistry
//
//  Created by rae on 2021/11/29.
//

import Foundation

struct ArtistsJson: Codable {
    let artists: [Artist]
    
    static func jsonFromBundle() -> ArtistsJson? {
        let fileName = "artists"
        let extensionType = "json"
        
        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: extensionType) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            let artistsJson = try? JSONDecoder().decode(ArtistsJson.self, from: data)
            return artistsJson
        } catch {
            return nil
        }
    }
}
