//
//  EventTableViewCell.swift
//  MarvelApp
//
//  Created by Milton Orellana on 18/05/2021.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 5
    }

    func configure(for event: Results) {
        let image = "\(event.thumbnail.path)/portrait_incredible.\(event.thumbnail.thumbnailExtension)"
        eventTitle.text = event.title
        eventImage.setImage(imageURL: image)
    }
}
