//
//  DiscoverMovie.swift
//  SMovie
//
//  Created by Eduard Tokarev on 11.04.2023.
//

import Foundation

struct MovieResult: Codable {
    let page: Int
    let results: [ResultMovie]
    let totalPages, totalResults: Int
}

struct ResultMovie: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let shazam: String?
}
