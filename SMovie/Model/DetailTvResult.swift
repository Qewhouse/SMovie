//
//  DetailTvResult.swift
//  SMovie
//
//  Created by Eduard Tokarev on 11.04.2023.
//

import Foundation

struct DetailTvResult: Codable {
    let episodeRunTime: [Int]
    let firstAirDate: String
    let genres: [Genre]
    let name: String
    let overview: String
    let popularity: Double
    let posterPath: String
}
