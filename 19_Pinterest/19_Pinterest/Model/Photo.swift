//
//  Photo.swift
//  19_Pinterest
//
//  Created by rae on 2021/12/30.
//

import UIKit

class Photo {
    var caption: String
    var comment: String
    var image: UIImage
    
    init(caption: String, comment: String, image: UIImage) {
        self.caption = caption
        self.comment = comment
        self.image = image
    }
    
    convenience init(dictionary: NSDictionary) {
        let caption = dictionary["Caption"] as? String ?? ""
        let comment = dictionary["Comment"] as? String ?? ""
        let photo = dictionary["Photo"] as? String ?? ""
        let image = UIImage(named: photo) ?? UIImage()
        
        self.init(caption: caption, comment: comment, image: image)
    }
    
    class func getAllPhotos() -> [Photo] {
        var photos = [Photo]()
        guard let url = Bundle.main.url(forResource: "Photos", withExtension: "plist") else {
            return photos
        }
        
        guard let array = NSArray(contentsOf: url) else {
            return photos
        }
        
        for dictionary in array {
            let photo = Photo(dictionary: dictionary as! NSDictionary)
            photos.append(photo)
        }
        
        return photos
    }
}
