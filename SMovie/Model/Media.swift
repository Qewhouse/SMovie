//
//  Media.swift
//  SMovie
//
//  Created by Eduard Tokarev on 12.04.2023.
//

import Foundation

struct Media {
    let id: Int?
    let name: String?
    let title: String?
    let overview: String?
    let genreIds: [Int]?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let mediaType: MediaType?
    let firstAirDate: String?
    
    init(from result: Find) {
            self.id = result.id
            self.title = result.title
            self.overview = result.overview
            self.genreIds = result.genreIds
            self.posterPath = result.posterPath
            self.mediaType = result.mediaType
            self.releaseDate = result.releaseDate
            self.name = result.name
            self.popularity = result.popularity
            self.firstAirDate = result.firstAirDate
    }
}
