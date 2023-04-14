//
//  DetailMedia.swift
//  SMovie
//
//  Created by Eduard Tokarev on 14.04.2023.
//

import Foundation

struct DetailMediaResult: Codable {
    let id: Int?
    let genres: [Genre]?
    let overview: String?
    let vote_average: Double?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let title: String?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let name: String?
}
