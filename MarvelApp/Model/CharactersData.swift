//
//  Characters.swift
//  MarvelApp
//
//  Created by Milton Orellana on 11/05/2021.
//

import Foundation

struct CharactersData: Codable {
    let data: Data
}

struct Data: Codable {
    let results: [Results]
    let count: Int
}

struct Results: Codable {
    let title: String?
    let id: Int
    let name: String?
    let description: String
    let thumbnail: Thumbnail
    let comics: Comics
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

struct Comics: Codable {
    let returned: Int
    let items: [Items]
}

struct Items: Codable {
    let name: String?
}
