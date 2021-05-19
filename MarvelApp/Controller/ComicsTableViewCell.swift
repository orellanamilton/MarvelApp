//
//  ComicsTableViewCell.swift
//  MarvelApp
//
//  Created by Milton Orellana on 18/05/2021.
//

import UIKit

class ComicsTableViewCell: UITableViewCell {
    @IBOutlet weak var comicLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(for comic: Items) {
        comicLabel.text = comic.name
    }
    
}

