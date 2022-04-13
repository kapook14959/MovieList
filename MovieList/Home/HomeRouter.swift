//
//  HomeRouter.swift
//  MovieList
//
//  Created by Supakorn Siripisitwong on 1/4/2565 BE.
//

import UIKit
import Foundation

protocol HomeRouterInterface {
    func createVC() -> UIViewController
    func navigateToList(data: MovieListResponse?, listTypes: ListModels.ListTypes)
}

class HomeRouter: HomeRouterInterface {
    weak var viewController: HomeViewController!

    // MARK: - Navigation

    func createVC() -> UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeViewController")
        return vc
    }
        
    func navigateToList(data: MovieListResponse?, listTypes: ListModels.ListTypes) {
        guard let listVC = ListRouter().createVC() as? ListViewController else { return }
        listVC.interactor.data = data
        listVC.interactor.listTypes = listTypes
        viewController.navigationController?.pushViewController(listVC, animated: true)
    }
}
