

import Foundation

import Foundation
import CryptoKit

final class marvelAPI {
    
    static let shared = marvelAPI()
    
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
    
    func FetchData(completionHandler:@escaping ([MarvelApiData]) -> Void) {
        var marvelList = [MarvelApiData]()
        let hash = MD5(data: "1\(privateKey)\(publicKey)")
        if let url = URL.init(string: ) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
                if error != nil {
                    print("error")
                } else {
                    if let responseText = String.init(data: data!, encoding: .ascii) {
                        let jsonData = responseText.data(using: .utf8)!
                        marvelList = try! JSONDecoder().decode([MarvelApiData].self, from: jsonData)
                        completionHandler(marvelList)
                    }
                }
            })
            task.resume()
        }
        
    }
}
