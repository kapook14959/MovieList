//
//  UserPreference.swift
//  MovieList
//
//  Created by Supakorn Siripisitwong on 5/4/2565 BE.
//

// Singleton

import Foundation

class UserPreference {
    static let shared = UserPreference()
    
    func getMoviesFavourite() -> MovieListResponse? {
        if let data = UserDefaults.standard.value(forKey: "moviesFav") as? Data {
           return try? PropertyListDecoder().decode(MovieListResponse.self, from: data)
        }
        return nil
    }
    
    func getHistory() -> [String]? {
        if let data = UserDefaults.standard.value(forKey: "history") as? Data {
            return try? PropertyListDecoder().decode([String].self, from: data)
        }
        return nil
    }
    
    func setMoviesResult(moviesResponse: MovieListResponse, data: MovieListResult) {
        if let movies = getMoviesFavourite() {
            var arrays: [MovieListResult] = movies.results
            arrays.append(data)
            let response = MovieListResponse(results: arrays,
                                             totalResults: moviesResponse.totalResults,
                                             totalPages: moviesResponse.totalPages,
                                             page: moviesResponse.page)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(response), forKey: "moviesFav")
        } else {
            let response = MovieListResponse(results: [data],
                                             totalResults: moviesResponse.totalResults,
                                             totalPages: moviesResponse.totalPages,
                                             page: moviesResponse.page)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(response), forKey: "moviesFav")
        }
    }
    
    func setHistory(history: String) {
        if let historyPref = getHistory() {
            var arrays = historyPref
            arrays.append(history)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(arrays), forKey: "history")
        } else {
            UserDefaults.standard.set(try? PropertyListEncoder().encode([history]), forKey: "history")
        }
    }
    
    func removeMoviesResult(overview: String) {
        if let movies = getMoviesFavourite() {
            var arrays: [MovieListResult] = movies.results
            for (index, value) in movies.results.enumerated() {
                if value.overview == overview {
                    arrays.remove(at: index)
                }
            }
            let response = MovieListResponse(results: arrays,
                                             totalResults: movies.totalResults,
                                             totalPages: movies.totalPages,
                                             page: movies.page)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(response), forKey: "moviesFav")
        }
    }
    
    func removeHistory() {
        if let history = getHistory() {
            var arrays = history
            arrays.removeFirst()
            UserDefaults.standard.set(try? PropertyListEncoder().encode(arrays), forKey: "history")
        }
    }
}
