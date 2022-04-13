//
//  HomeModel.swift
//  MovieList
//
//  Created by Supakorn Siripisitwong on 1/4/2565 BE.
//

import Foundation

struct HomeModel {
    struct GetHistory {
        struct Request {
            let search: [String]
            let searchText: String?
        }
        
        struct Response {
            let search: [String]
        }
        
        struct ViewModel {
            let search: [String]
        }
    }
    
    struct SearchMovie {
        struct Request {
            let searchText: String?
        }
        
        struct Response {
            let response: Result<MovieListResponse, Error>
        }
        
        struct ViewModel {
            let response: Result<MovieListResponse, Error>
        }
    }
}
