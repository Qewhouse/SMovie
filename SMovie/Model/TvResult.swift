//
//  TvResult.swift
//  SMovie
//
//  Created by Eduard Tokarev on 11.04.2023.
//

import Foundation

struct TvResult: Codable {
    let page: Int
    let results: [ResultTv]
    let totalPages, totalResults: Int
}

struct ResultTv: Codable {
    let backdropPath, firstAirDate: String
    let genreIds: [Int]
    let id: Int
    let name: String
    let originCountry: [String]
    let originalLanguage: String
    let originalName, overview: String
    let popularity: Double
    let posterPath: String
    let voteAverage: Double
    let voteCount: Int
    let mazarita, ghaith: String?
}

