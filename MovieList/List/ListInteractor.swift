//
//  ListInteractor.swift
//  MovieList

import UIKit

protocol ListInteractorOutput: AnyObject {
    var data: MovieListResponse? { get set }
    var listTypes: ListModels.ListTypes! { get set }
}

final class ListInteractor: ListInteractorOutput {
    var presenter: ListPresenterOutput!
    var data: MovieListResponse?
    var listTypes: ListModels.ListTypes!
    
    // MARK: - Business logic
}
