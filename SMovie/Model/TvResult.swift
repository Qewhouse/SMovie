//
//  TvResult.swift
//  SMovie
//
//  Created by Eduard Tokarev on 11.04.2023.
//

import Foundation

struct TvResult: Codable {
    let results: [ResultTv]
}

struct ResultTv: Codable {
    let firstAirDate: String
    let genreIds: [Int]
    let id: Int
    let name: String
    let overview: String
    let popularity: Double
    let posterPath: String
}

