//
//  SearchResult.swift
//  SMovie
//
//  Created by Eduard Tokarev on 12.04.2023.
//

import Foundation

struct SearchResult {
    let page: Int
    let results: [Find]
    let totalPages, totalResults: Int
}

struct Find {
    let id: Int
    let name: String
}
