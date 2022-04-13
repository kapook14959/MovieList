//
//  MovieListResponse.swift
//  MovieList
//
//  Created by Supakorn Siripisitwong on 4/4/2565 BE.
//

struct MovieListResponse: Codable {
    let results: [MovieListResult]
    let totalResults: Int
    let totalPages: Int
    let page: Int
}

struct MovieListResult: Codable {
    let posterPath: String
    let releaseDate: String
    let voteAverage: Float
    let originalTitle: String
    let overview: String
    let title: String
}

extension MovieListResponse {
    private enum CodingKeys: String, CodingKey {
        case results, totalResults = "total_results", totalPages = "total_pages", page
    }
}

extension MovieListResult {
    private enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path", releaseDate = "release_date", voteAverage = "vote_average", originalTitle = "original_title", overview, title
    }
}
