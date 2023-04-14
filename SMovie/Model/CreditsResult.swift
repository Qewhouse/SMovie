//
//  CreditsResult.swift
//  SMovie
//
//  Created by Eduard Tokarev on 14.04.2023.
//

import Foundation

struct Credits: Codable {
    
    let cast, crew: [Cast]
}

struct Cast: Codable {
    let id: Int?
    let name: String?
    let profilePath: String?
    let character, job: String?
}
