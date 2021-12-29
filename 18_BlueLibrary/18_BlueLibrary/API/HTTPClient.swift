//
//  HTTPClient.swift
//  18_BlueLibrary
//
//  Created by rae on 2021/12/27.
//

import UIKit

class HTTPClient {
    func downloadImage(_ url: String) -> (UIImage) {
        let aUrl = URL(string: url)
        
        guard let data = try? Data(contentsOf: aUrl!) else {
            return UIImage()
        }
        
        guard let image = UIImage(data: data) else {
            return UIImage()
        }
        
        return image
    }
}
