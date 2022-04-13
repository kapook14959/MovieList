//
//  ListViewController.swift
//  MovieList

import UIKit

protocol ListViewControllerOutput: AnyObject {
}

final class ListViewController: UIViewController {
    var interactor: ListInteractorOutput!
    var router: ListRouterInput!
    
    @IBOutlet private weak var tableView: UITableView!
    private var userPreference = UserPreference.shared
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let router = ListRouter()
        router.viewController = self
        
        let presenter = ListPresenter()
        presenter.viewController = self
        
        let interactor = ListInteractor()
        interactor.presenter = presenter
        
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ListCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - SetupViews
    
    // MARK: - Event handling
    
    // MARK: - Actions
    
    // MARK: - Private func
}

// MARK: - Display logic

extension ListViewController: ListViewControllerOutput {
    
}

// MARK: - Start Any Extensions

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.data?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListTableViewCell,
              let results = interactor.data?.results[indexPath.row] else { return UITableViewCell() }
        let model = ListTableViewCellModel(imagePath: results.posterPath,
                                           title: results.title,
                                           releaseDate: results.releaseDate,
                                           detail: results.overview)
        cell.updateUI(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = interactor.data?.results[indexPath.row] else { return }
        router.navigateToDetail(data: data)
    }
}

extension ListViewController: DetailViewControllerDelegate {
    func didTapFavourite(listTypes: ListModels.ListTypes) {
        switch listTypes {
        case .favourite:
            if let favData = userPreference.getMoviesFavourite() {
                interactor.data = favData
                tableView.reloadData()
            }
        default: break
        }
    }
}
