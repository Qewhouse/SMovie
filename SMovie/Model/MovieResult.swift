//
//  DiscoverMovie.swift
//  SMovie
//
//  Created by Eduard Tokarev on 11.04.2023.
//

import Foundation

struct MovieResult: Codable {
    let results: [ResultMovie]
}

struct ResultMovie: Codable {
    let genreIds: [Int]
    let id: Int
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
}
