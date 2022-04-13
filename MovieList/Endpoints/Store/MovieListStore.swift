//
//  MovieListStore.swift
//  MovieList
//
//  Created by Supakorn Siripisitwong on 4/4/2565 BE.
//

import Foundation

class MovieListStore: MovieListStoreProtocol {
    let baseUrl = "https://api.themoviedb.org/"
    let apiKey = "596243024ca459523610966a8f2fefaf"
    
    enum Endpoints: String {
        case search = "3/search/movie"
    }
    
    func searchMovie(query: String, page: Int, _ completion: @escaping (Result<MovieListResponse, ErrorModel>) -> Void) {
        let searchEndpoint = "\(baseUrl)\(Endpoints.search.rawValue)"
        let fullUrl = "\(searchEndpoint)?api_key=\(apiKey)&language=en-US&query=\(query)&page\(page)&include_adult=false"
        
        let url = URL(string: fullUrl)
        var request = URLRequest(url: url!)
        request.setValue(apiKey, forHTTPHeaderField: "api-key")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let dataValid = data {
                do {
                    let json = try JSONDecoder().decode(MovieListResponse.self, from: dataValid)
                    DispatchQueue.main.async {
                        completion(.success(json))
                    }
                } catch let error {
                    let errorModel = ErrorModel(title: "Error", description: error.localizedDescription)
                    DispatchQueue.main.async {
                        completion(.failure(errorModel))
                    }
                }
            } else {
                let errorModel = ErrorModel(title: "Error", description: "Cannot get data, Please try again")
                DispatchQueue.main.async {
                    completion(.failure(errorModel))
                }
            }
        }.resume()
    }
}
