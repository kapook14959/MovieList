//
//  ListPresenter.swift
//  MovieList

import UIKit

protocol ListPresenterOutput: AnyObject {
}

final class ListPresenter: ListPresenterOutput {
    weak var viewController: ListViewControllerOutput?

    // MARK: - Presentation logic
}
