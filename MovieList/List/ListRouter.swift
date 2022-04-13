//
//  ListRouter.swift
//  MovieList

import UIKit

protocol ListRouterInput: AnyObject {
    func createVC() -> UIViewController
    func navigateToDetail(data: MovieListResult)
}

final class ListRouter: ListRouterInput {
    weak var viewController: ListViewController!

    // MARK: - Navigation

    func createVC() -> UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "List", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ListViewController")
        return vc
    }
    
    func navigateToDetail(data: MovieListResult) {
        guard let detailVC = DetailRouter().createVC() as? DetailViewController else { return }
        detailVC.interactor.listTypes = viewController.interactor.listTypes
        detailVC.delegate = viewController
        detailVC.interactor.data = data
        detailVC.interactor.moviesResponse = viewController.interactor.data
        viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
}
