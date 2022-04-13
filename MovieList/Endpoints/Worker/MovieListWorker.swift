//
//  MovieListWorker.swift
//  MovieList
//
//  Created by Supakorn Siripisitwong on 4/4/2565 BE.
//

import Foundation

protocol MovieListStoreProtocol {
    func searchMovie(query: String, page: Int, _ completion: @escaping (Result<MovieListResponse, ErrorModel>) -> Void)
}

class MovieListWorker {
    let store: MovieListStoreProtocol
    init(store: MovieListStoreProtocol) {
        self.store = store
    }
    
    func searchMovie(query: String, page: Int, _ completion: @escaping (Result<MovieListResponse, ErrorModel>) -> Void) {
        store.searchMovie(query: query, page: page, completion)
    }
}
