//
//  NetworkManager.swift
//  17_Movies
//
//  Created by rae on 2021/12/22.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let apiKey = "0e21e60db0a315baf24d7d45bf7c6834"
    
    func getPopularMovieLists(page: Int, completion: @escaping (Result<Movies, CustomError>) -> Void) {
        let address = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=ko-KR&page=\(page)"
        
        guard let url = URL(string: address) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
                
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            do {
                let movies = try JSONDecoder().decode(Movies.self, from: data)
                completion(.success(movies))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        dataTask.resume()
    }

}

enum CustomError: String, Error {
    case invalidUrl = "Invalid URL"
    case invalidData = "Invalid Data"
}
