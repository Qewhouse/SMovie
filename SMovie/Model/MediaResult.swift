//
//  SearchResult.swift
//  SMovie
//
//  Created by Eduard Tokarev on 12.04.2023.
//

import Foundation


struct MediaResult: Codable {
    let results: [Find]
}

struct Find: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let posterPath: String?
    var mediaType: MediaType?
    let genreIds: [Int]?
    let releaseDate: String?
    let name: String?
    let firstAirDate: String?
    let popularity: Double?
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
    case person = "person"
}
