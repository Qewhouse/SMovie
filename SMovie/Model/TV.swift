//
//  Model.swift
//  SMovie
//
//  Created by Eduard Tokarev on 11.04.2023.
//

import Foundation

struct TV {
    let id: Int
    let name: String
    let overview: String
    let genreIds: [Int]
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    
    init(from result: ResultTv) {
        id = result.id
        name = result.name
        overview = result.overview
        genreIds = result.genreIds
        popularity = result.popularity
        posterPath = result.posterPath
        releaseDate = result.firstAirDate
    }
}
