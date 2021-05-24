//
//  EventsViewController.swift
//  MarvelApp
//
//  Created by Milton Orellana on 11/05/2021.
//

import UIKit
import Alamofire
import CryptoKit
import Hero

class EventsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var events: [Results] =  []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableHero()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disableHero()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EventCell")
        
        EventsAPI()
    }
    
    
    var publicKey = "8f32a6fa5d6428ef9d5aac4148a5ff83"
    var privateKey = "026722947f71fa964186c43fe604d49a36d6317a"
    let urlBase = "https://gateway.marvel.com/v1/public/events?ts=1"
    
    func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8)!)
        
        return hash.map{
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
    
    func EventsAPI() {
        let hash = MD5(data: "1\(privateKey)\(publicKey)")
        let urlString = "\(urlBase)&apikey=\(publicKey)&hash=\(hash)"
        let request = AF.request(urlString)
        
        request.responseJSON { (response) in
            do {
                guard let data = response.data else {
                    return
                }
                let decode = JSONDecoder()
                let listOfEvents = try decode.decode(CharactersData.self, from: data)
                self.events = listOfEvents.data.results
                self.tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let event = events[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventTableViewCell
        cell.configure(for: event)
        cell.selectionStyle = .none
        cell.heroID = "eventCell"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "EventsDetails", bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? EventsDetailsViewController {
            viewController.event = self.events[indexPath.row]
            self.showHero(viewController)
        }
    }
}


