//
//  DetailPresenter.swift
//  MovieList

import UIKit

protocol DetailPresenterOutput: AnyObject {
}

final class DetailPresenter: DetailPresenterOutput {
    weak var viewController: DetailViewControllerOutput?

    // MARK: - Presentation logic

}
