//
//  EventDetailsTableViewCell.swift
//  MarvelApp
//
//  Created by Milton Orellana on 19/05/2021.
//

import UIKit

class EventDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var eventLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(for comic: Items) {
        eventLabel.text = comic.name
    }
}
