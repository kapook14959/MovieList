//
//  DetailViewController.swift
//  MovieList

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func didTapFavourite(listTypes: ListModels.ListTypes)
}

protocol DetailViewControllerOutput: AnyObject {
}

final class DetailViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var vote: UILabel!
    @IBOutlet private weak var overView: UILabel!
    @IBOutlet private weak var imageMovie : UIImageView!
    @IBOutlet private weak var favouriteButton: UIButton!
    
    var interactor: DetailInteractorOutput!
    var router: DetailRouterInput!
    var favourite: Bool = false
    var userPreference = UserPreference.shared
    weak var delegate: DetailViewControllerDelegate?
    
    private let likeMovie = UIImage(named: "heart_red")
    private let unlikeMovie = UIImage(named: "heart")
    
    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        let router = DetailRouter()
        router.viewController = self

        let presenter = DetailPresenter()
        presenter.viewController = self

        let interactor = DetailInteractor()
        interactor.presenter = presenter

        self.interactor = interactor
        self.router = router
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - SetupViews
    
    private func setupViews() {
        let fullUrl = "https://image.tmdb.org/t/p/w92\(interactor.data.posterPath)"
        titleLabel.text = interactor.data.title
        vote.text = "Average Vote \(interactor.data.voteAverage)"
        overView.text = interactor.data.overview
        imageMovie.downloadImage(from: URL(string: fullUrl)!)
        let movieFav = userPreference.getMoviesFavourite()
        if movieFav == nil {
            favouriteButton.setImage(unlikeMovie, for: .normal)
            favourite = false
        } else if movieFav != nil {
            movieFav?.results.forEach({ result in
                if result.overview == interactor.data.overview {
                    favourite = true
                }
            })
            
            if favourite {
                favouriteButton.setImage(likeMovie, for: .normal)
            } else {
                favouriteButton.setImage(unlikeMovie, for: .normal)
            }
        }
    }

    // MARK: - Event handling

    // MARK: - Actions
    
    @IBAction private func didTapFavouriteButton() {
        if !favourite {
            favouriteButton.setImage(likeMovie, for: .normal)
            userPreference.setMoviesResult(moviesResponse: interactor.moviesResponse,
                                           data: interactor.data)
            favourite = true
        } else {
            favouriteButton.setImage(unlikeMovie, for: .normal)
            userPreference.removeMoviesResult(overview: interactor.data.overview)
            favourite = false
        }
        delegate?.didTapFavourite(listTypes: interactor.listTypes)
    }
    
    // MARK: - Private func
}

// MARK: - Display logic

extension DetailViewController: DetailViewControllerOutput {
    
}

// MARK: - Start Any Extensions
