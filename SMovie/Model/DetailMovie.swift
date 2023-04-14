//
//  DetailMovie.swift
//  SMovie
//
//  Created by Eduard Tokarev on 11.04.2023.
//

import Foundation

struct DetailMovie {
    let name: String
    let overview: String
    let genres: [Genre]
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let runtime: Int
    
    init(from result: DetailMovieResult) {
        name = result.title
        overview = result.overview
        genres = result.genres
        popularity = result.popularity
        posterPath = result.posterPath
        releaseDate = result.releaseDate
        runtime = result.runtime
    }
}
