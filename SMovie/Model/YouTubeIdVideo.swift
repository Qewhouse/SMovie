//
//  YouTubeIdVideo.swift
//  SMovie
//
//  Created by Eduard Tokarev on 22.04.2023.
//

import Foundation

struct YouTubeIdVideo: Codable {
    let id: Int?
    let results: [ResultId]?
}

struct ResultId: Codable {
    let key: String?
}

struct videoYouTube: Codable {
    let items: [Item]?
}

struct Item: Codable {
    let player: Player?
}
struct Player: Codable {
    let embedHtml: String?
}
