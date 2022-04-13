//
//  ListTableViewCell.swift
//  MovieList
//
//  Created by Supakorn Siripisitwong on 4/4/2565 BE.
//

import Foundation
import UIKit

struct ListTableViewCellModel {
    let imagePath: String
    let title: String
    let releaseDate: String
    let detail: String
}

class ListTableViewCell: UITableViewCell {
    @IBOutlet private weak var imageMovie: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var detail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(model: ListTableViewCellModel) {
        let fullUrl = "https://image.tmdb.org/t/p/w92\(model.imagePath)"
        imageMovie.downloadImage(from: URL(string: fullUrl)!)
        title.text = model.title
        releaseDate.text = model.releaseDate
        detail.text = model.detail
    }
}
