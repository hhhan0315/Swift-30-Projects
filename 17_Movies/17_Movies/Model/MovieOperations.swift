//
//  MovieOperations.swift
//  17_Movies
//
//  Created by rae on 2021/12/23.
//

import UIKit

enum MovieRecordState {
    case new, downloaded, filtered, failed
}

class MovieRecord {
    let title: String
    let posterPath: String
    var state: MovieRecordState = .new
    var image = UIImage(systemName: "placeholdertext.fill")
    
    init(title: String, posterPath: String) {
        self.title = title
        self.posterPath = posterPath
    }
}

class PendingOperations {
    lazy var downloadsInProgress: [IndexPath: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download Queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    lazy var filterInProgress: [IndexPath: Operation] = [:]
    lazy var filterQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Image Filter Queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}

class ImageDownloader: Operation {
    let movieRecord: MovieRecord
    let networkManager = NetworkManager.shared
    
    init(_ movieRecord: MovieRecord) {
        self.movieRecord = movieRecord
    }
    
    override func main() {
        if isCancelled { return }
        
        let address = "https://image.tmdb.org/t/p/w500\(movieRecord.posterPath)"
        guard let url = URL(string: address) else { return }
        guard let imageData = try? Data(contentsOf: url) else { return }
        
        if isCancelled { return }
        
        if !imageData.isEmpty {
            movieRecord.image = UIImage(data: imageData)
            movieRecord.state = .downloaded
        } else {
            movieRecord.image = UIImage(systemName: "placeholdertext.fill")
            movieRecord.state = .failed
        }
    }
}

class ImageFilter: Operation {
    let movieRecord: MovieRecord
    
    init(_ movieRecord: MovieRecord) {
        self.movieRecord = movieRecord
    }
    
    override func main() {
        if isCancelled { return }
        
        guard self.movieRecord.state == .downloaded else { return }
        
        if let image = movieRecord.image,
           let filteredImage = applyFilter(image) {
            movieRecord.image = filteredImage
            movieRecord.state = .filtered
        }
    }
    
    func applyFilter(_ image: UIImage) -> UIImage? {
        guard let data = image.pngData() else { return nil}
        let inputImage = CIImage(data: data)
        
        if isCancelled { return nil }
        
        let context = CIContext(options: nil)
        
        guard let filter = CIFilter(name: "CISepiaTone") else { return nil }
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(0.8, forKey: "inputIntensity")
        
        if isCancelled { return nil }
        
        if let outputImage = filter.outputImage,
           let outImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: outImage)
        } else {
            return nil
        }
    }
}
