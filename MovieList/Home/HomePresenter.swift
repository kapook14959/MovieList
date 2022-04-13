//
//  HomePresenter.swift
//  MovieList
//
//  Created by Supakorn Siripisitwong on 1/4/2565 BE.
//

import Foundation

protocol HomePresenterInterface {
    func presentHistory(response: HomeModel.GetHistory.Response)
    func presentMovie(response: HomeModel.SearchMovie.Response)
}

class HomePresenter: HomePresenterInterface {
    var viewController: HomeViewControllerInterface!
    
    func presentHistory(response: HomeModel.GetHistory.Response) {
        let viewModel = HomeModel.GetHistory.ViewModel(search: response.search)
        viewController.displayHistory(viewModel: viewModel)
    }
    
    func presentMovie(response: HomeModel.SearchMovie.Response) {
        let viewModel = HomeModel.SearchMovie.ViewModel(response: response.response)
        viewController.displayMovie(viewModel: viewModel)
    }
}
