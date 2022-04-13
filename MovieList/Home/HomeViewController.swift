//
//  HomeViewController.swift
//  MovieList
//
//  Created by Supakorn Siripisitwong on 1/4/2565 BE.
//

import UIKit

protocol HomeViewControllerInterface {
    func displayHistory(viewModel: HomeModel.GetHistory.ViewModel)
    func displayMovie(viewModel: HomeModel.SearchMovie.ViewModel)
}

class HomeViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    var search: [String] = []
    var interactor: HomeInteractorInterface!
    var router: HomeRouterInterface!
    var userPreference = UserPreference.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let historyInteractor = HomeInteractor()
        let historyPresenter = HomePresenter()
        let router = HomeRouter()
        interactor = historyInteractor
        historyInteractor.presenter = historyPresenter
        historyPresenter.viewController = self
        self.router = router
        router.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "HistoryCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HistoryCell")
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.searchTextField.backgroundColor = .white
        let buttonItem = UIBarButtonItem(title: "favourite",
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapFavButton))
        buttonItem.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = buttonItem
        searchBar.delegate = self
        interactor.getHistory(request: HomeModel.GetHistory.Request(search: search, searchText: ""))
        interactor.firstComing = false
    }
    
    @objc private func didTapFavButton() {
        let favData = userPreference.getMoviesFavourite()
        router.navigateToList(data: favData, listTypes: .favourite)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return search.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else { return UITableViewCell() }
        cell.updateUI(searchKey: search[indexPath.row])
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.text = search[indexPath.row]
        let searchMovieRequest = HomeModel.SearchMovie.Request(searchText: searchBar.text)
        interactor.searchMovie(request: searchMovieRequest)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchMovieRequest = HomeModel.SearchMovie.Request(searchText: searchBar.text)
        interactor.searchMovie(request: searchMovieRequest)
    }
}

extension HomeViewController: HomeViewControllerInterface {
    func displayHistory(viewModel: HomeModel.GetHistory.ViewModel) {
        search = viewModel.search
        tableView.reloadData()
    }
    
    func displayMovie(viewModel: HomeModel.SearchMovie.ViewModel) {
        switch viewModel.response {
        case .success(let data):
            router.navigateToList(data: data, listTypes: .normal)
        case .failure(let error):
            guard let errorModel = error as? ErrorModel else { return }
            let alert = UIAlertController(title: errorModel.title, message: errorModel.description, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
