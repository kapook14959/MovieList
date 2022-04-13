//
//  HistoryCell.swift
//  MovieList
//
//  Created by Supakorn Siripisitwong on 1/4/2565 BE.
//

import UIKit

class HistoryCell: UITableViewCell {
    @IBOutlet private weak var historyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(searchKey: String) {
        historyLabel.text = searchKey
    }
}
