//
//  DetailInteractor.swift
//  MovieList

import UIKit

protocol DetailInteractorOutput: AnyObject {
    var data: MovieListResult! { get set }
    var moviesResponse: MovieListResponse! { get set }
    var listTypes: ListModels.ListTypes! { get set }
}

final class DetailInteractor: DetailInteractorOutput {
    var presenter: DetailPresenterOutput!
    var data: MovieListResult!
    var moviesResponse: MovieListResponse!
    var listTypes: ListModels.ListTypes!

    // MARK: - Business logic

}
