//
//  DetailRouter.swift
//  MovieList

import UIKit

protocol DetailRouterInput: AnyObject {
    func createVC() -> UIViewController
}

final class DetailRouter: DetailRouterInput {
    weak var viewController: DetailViewController!

    // MARK: - Navigation

    func createVC() -> UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DetailViewController")
        return vc
    }
}
