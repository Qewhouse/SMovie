//
//  DetailMedia.swift
//  SMovie
//
//  Created by Eduard Tokarev on 14.04.2023.
//

import Foundation

struct DetailMedia {
    let id: Int?
    let name: String?
    let overview: String?
    let genres: [Genre]?
    let vote_average: Double?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let title: String?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    
    init(from result: DetailMediaResult) {
        id = result.id
        name = result.name
        overview = result.overview
        genres = result.genres
        vote_average = result.vote_average
        posterPath = result.posterPath
        releaseDate = result.releaseDate
        runtime = result.runtime
        title = result.title
        episodeRunTime = result.episodeRunTime
        firstAirDate = result.firstAirDate
    }
}
