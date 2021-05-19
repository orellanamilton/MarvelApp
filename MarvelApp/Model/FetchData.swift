//
//  FetchData.swift
//  MarvelApp
//
//  Created by Milton Orellana on 12/05/2021.
//

import Foundation
import CryptoKit

final class marvelAPI {
    
    static let shared = marvelAPI()
    
    var publicKey = "8f32a6fa5d6428ef9d5aac4148a5ff83"
    var privateKey = "026722947f71fa964186c43fe604d49a36d6317a"
    let urlBase = "https://gateway.marvel.com:443/v1/public/characters?ts=1"
    
    func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map{
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
    func fetchData() {
        let hash = MD5(data: "1\(privateKey)\(publicKey)")
        let url = URL(string: "\(urlBase)&apikey=\(publicKey)&hash=\(hash)")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                print("error")
                return
            }
            
            guard let marvelList = try? JSONDecoder().decode(MarvelApiData.self, from: data) else {
                print("error")
                return
            }
            print(marvelList.data)
        }
        task.resume()
    }
}

