//
//  DetailMovieResult.swift
//  SMovie
//
//  Created by Eduard Tokarev on 11.04.2023.
//

import Foundation

struct DetailMovieResult: Codable {
    let genres: [Genre]
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let runtime: Int
    let title: String
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
