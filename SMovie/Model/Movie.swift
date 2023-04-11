//
//  ModelMoview.swift
//  SMovie
//
//  Created by Eduard Tokarev on 11.04.2023.
//

import Foundation

struct Movie {
    let id: Int
    let name: String
    let overview: String
    let genreIds: [Int]
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    
    init(from result: ResultMovie) {
        id = result.id
        name = result.title
        overview = result.overview
        genreIds = result.genreIds
        popularity = result.popularity
        posterPath = result.posterPath
        releaseDate = result.releaseDate
    }
}
