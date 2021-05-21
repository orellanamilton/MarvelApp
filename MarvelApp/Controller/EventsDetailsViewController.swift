//
//  EventsDetailsViewController.swift
//  MarvelApp
//
//  Created by Milton Orellana on 19/05/2021.
//

import UIKit

class EventsDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    @IBOutlet weak var eventImage: UIImageView!
    
    var event: Results!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "EventDetailsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EventDetailsCell")

        title = event.title
        
        
        let image = "\(event.thumbnail.path)/landscape_incredible.\(event.thumbnail.thumbnailExtension)"
        eventImage.setImage(imageURL: image)
        
        
        heightConstant.constant = CGFloat(Double(event.comics.items.count) * 55)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension EventsDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event.comics.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        let event = event.comics.items[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventDetailsCell") as! EventDetailsTableViewCell
        cell.configure(for: event)
        cell.selectionStyle = .none
        return cell
    }


}
