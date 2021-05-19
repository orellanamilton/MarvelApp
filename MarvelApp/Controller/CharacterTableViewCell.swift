//
//  CharacterTableViewCell.swift
//  MarvelApp
//
//  Created by Milton Orellana on 18/05/2021.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterTitle: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 5
    }

    
    func configure(for character: Results ) {
        let image = "\(character.thumbnail.path)/portrait_incredible.\(character.thumbnail.thumbnailExtension)"
        characterTitle.text = character.name
        characterImage.setImage(imageURL: image)
        
        if character.description == "" {
            characterDescription.text = "No description"
        } else {
            characterDescription.text = character.description
        }
    }
}
