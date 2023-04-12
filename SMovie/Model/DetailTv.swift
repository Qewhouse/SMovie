//
//  DetailTv.swift
//  SMovie
//
//  Created by Eduard Tokarev on 12.04.2023.
//

import Foundation

struct DetailTv {
    let name: String
    let overview: String
    let genres: [Genre]
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let runtime: [Int]
    
    init(from result: DetailTvResult) {
        name = result.name
        overview = result.overview
        genres = result.genres
        popularity = result.popularity
        posterPath = result.posterPath
        releaseDate = result.firstAirDate
        runtime = result.episodeRunTime
    }
}
