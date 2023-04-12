//
//  SearchResult.swift
//  SMovie
//
//  Created by Eduard Tokarev on 12.04.2023.
//

import Foundation


struct SearchResult: Codable {
    let results: [Find]
}

struct Find: Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let title, originalLanguage, originalTitle, overview: String?
    let posterPath: String?
    let mediaType: MediaType
    let genreIDS: [Int]?
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let name, originalName: String?
    let gender: Int?
    let knownForDepartment: String?
    let profilePath: String?
    let knownFor: [KnownFor]?
    let firstAirDate: String?
    let originCountry: [String]?
    let theGodsMustBeCrazy, fiercelyFanged: String?
}

// MARK: - KnownFor
struct KnownFor: Codable {
    let adult: Bool
    let id: Int
    let title, originalLanguage, originalTitle, overview: String
    let posterPath: String
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

enum MediaType: Codable {
    case movie
    case tv
}
