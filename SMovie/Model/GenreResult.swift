//
//  GenreResult.swift
//  SMovie
//
//  Created by Eduard Tokarev on 12.04.2023.
//

import Foundation

struct GenreResult: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
