//
//  HomeInteractor.swift
//  MovieList
//
//  Created by Supakorn Siripisitwong on 1/4/2565 BE.
//

import Foundation

protocol HomeInteractorInterface {
    func getHistory(request: HomeModel.GetHistory.Request)
    func searchMovie(request: HomeModel.SearchMovie.Request)
    var firstComing: Bool { get set }
}

class HomeInteractor: HomeInteractorInterface {
    var presenter: HomePresenterInterface!
    var worker = MovieListWorker(store: MovieListStore())
    var userPreference = UserPreference.shared
    var firstComing: Bool = true
    
    private var searchArrays: [String] = []
    
    // MARK: - Business Logic
    
    func getHistory(request: HomeModel.GetHistory.Request) {
        if let historyData = userPreference.getHistory(), firstComing {
            searchArrays = historyData
        } else {
            if request.search.count == 0 {
                if let searchText = request.searchText {
                    searchArrays.append(searchText)
                }
            } else if request.search.count <= 4 {
                appendData(search: request.search, searchText: request.searchText)
            } else if request.search.count == 5 {
                if validateSameValue(search: request.search, searchText: request.searchText) {
                    searchArrays.removeFirst()
                    userPreference.removeHistory()
                    appendData(search: request.search, searchText: request.searchText)
                }
            }
        }
        let response = HomeModel.GetHistory.Response(search: searchArrays.reversed())
        presenter.presentHistory(response: response)
    }
    
    func searchMovie(request: HomeModel.SearchMovie.Request) {
        worker.searchMovie(query: request.searchText ?? "", page: 1) { [weak self] response in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let data):
                if strongSelf.validateSameValue(search: strongSelf.searchArrays, searchText: request.searchText),
                   let searchText = request.searchText {
                    strongSelf.userPreference.setHistory(history: searchText)
                }
                strongSelf.getHistory(request: HomeModel.GetHistory.Request(search: strongSelf.searchArrays, searchText: request.searchText))
                let response = HomeModel.SearchMovie.Response(response: .success(data))
                strongSelf.presenter.presentMovie(response: response)
            case .failure(let error):
                let response = HomeModel.SearchMovie.Response(response: .failure(error))
                strongSelf.presenter.presentMovie(response: response)
            }
        }
    }
    
    // MARK: - Private func
    
    private func appendData(search: [String], searchText: String?) {
        if validateSameValue(search: search, searchText: searchText) {
            if let searchText = searchText {
                searchArrays.append(searchText)
            }
        }
    }
    
    private func validateSameValue(search: [String], searchText: String?) -> Bool {
        return search.filter { $0 == searchText }.isEmpty
    }
}
