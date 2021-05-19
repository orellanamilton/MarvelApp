//
//  EventsTableViewCell.swift
//  MarvelApp
//
//  Created by Milton Orellana on 18/05/2021.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(for event: Results) {
        let image = "\(event.thumbnail.path)/portrait_incredible.\(event.thumbnail.thumbnailExtension)"
        guard let title = event.title else {return}
        print(title
        )
        eventTitle.text = event.title
        eventImage.setImage(imageURL: image)
    }
}
