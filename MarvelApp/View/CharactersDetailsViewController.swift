//
//  DetailsViewController.swift
//  MarvelApp
//
//  Created by Milton Orellana on 18/05/2021.
//

import UIKit

class CharactersDetailsViewController: UIViewController {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var character: Results!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CharacterDetailsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CharacterDetailsCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        title = character.name
        
        heightConstant.constant = CGFloat(Double(character.comics.items.count) * 55)
        
        let image = "\(character.thumbnail.path)/landscape_incredible.\(character.thumbnail.thumbnailExtension)"
        characterImage.setImage(imageURL: image)
        
        if character.description == "" {
            descriptionLabel.text = "No description"
        } else {
            descriptionLabel.text = character.description
        }
    }
    
}

extension CharactersDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character.comics.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        let comic = character.comics.items[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterDetailsCell") as! CharacterDetailsTableViewCell
        cell.configure(for: comic)
        cell.selectionStyle = .none
        return cell
    }
    
}
