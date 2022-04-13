//
//  ErrorModel.swift
//  MovieList
//
//  Created by Supakorn Siripisitwong on 4/4/2565 BE.
//

struct ErrorModel: Error, Codable {
    let title: String
    let description: String
}
