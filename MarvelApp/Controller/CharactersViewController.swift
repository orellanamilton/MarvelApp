//
//  CharactersViewController.swift
//  MarvelApp
//
//  Created by Milton Orellana on 11/05/2021.
//

import UIKit
import CryptoKit
import Alamofire
import Hero


class CharactersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var character: [Results] =  []
    
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

        let nib = UINib(nibName: "CharacterTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CharacterCell")
        CharactersAPI()
    }
    
    var publicKey = "8f32a6fa5d6428ef9d5aac4148a5ff83"
    var privateKey = "026722947f71fa964186c43fe604d49a36d6317a"
    let urlBase = "https://gateway.marvel.com:443/v1/public/characters?ts=1"
    
    func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8)!)
        
        return hash.map{
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
    func CharactersAPI() {
        let hash = MD5(data: "1\(privateKey)\(publicKey)")
        let urlString = "\(urlBase)&apikey=\(publicKey)&hash=\(hash)"
        let request = AF.request(urlString)
        
        request.responseJSON { (response) in
            do {
                guard let data = response.data else {
                    return
                }
                let decode = JSONDecoder()
                let listOfCharacters = try decode.decode(CharactersData.self, from: data)
                self.character = listOfCharacters.data.results
                self.tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
}



extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let character = character[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as! CharacterTableViewCell
        cell.selectionStyle = .none
        cell.configure(for: character)
        cell.heroID = "characterCell"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "CharactersDetails", bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? CharactersDetailsViewController {
            viewController.character = self.character[indexPath.row]
            self.showHero(viewController)
        }
    }
}

