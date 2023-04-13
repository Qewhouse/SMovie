//
//  HomeMockData.swift
//  SMovie
//
//  Created by Вова on 10.04.2023.
//

import Foundation

struct HomeMockData {
    static let shared = HomeMockData()
    private let poster: ListSection = {
        .posters([.init(title: "Sea Beast", image: "Sea Beast", category: "Adventure", time: 0, rank: 0),
                  .init(title: "Thor: Love and Thunder", image: "Thor", category: "Action", time: 0, rank: 0),
                  .init(title: "Luck", image: "Luck", category: "Mystery", time: 0, rank: 0)
        ])
    }()
    
    private let category: ListSection = {
        .categories([.init(title: "", image: "", category: "All", time: 0, rank: 0),
                     .init(title: "", image: "", category: "Action", time: 0, rank: 0),
                     .init(title: "", image: "", category: "Adventure", time: 0, rank: 0),
                     .init(title: "", image: "", category: "Mistery", time: 0, rank: 0),
                     .init(title: "", image: "", category: "Fantasy", time: 0, rank: 0),
                     .init(title: "", image: "", category: "Others", time: 0, rank: 0)
        ])
    }()
    
    private let example: ListSection = {
        .examples([.init(title: "Thor", image: "Thor", category: "Action", time: 144, rank: 4.4),
                   .init(title: "Sea Beast", image: "Sea Beast", category: "Adventure", time: 144, rank: 4.4),
                   .init(title: "Luck", image: "Luck", category: "Mystery", time: 144, rank: 4.4),
                   .init(title: "Thor", image: "Thor", category: "Action", time: 144, rank: 4.4),
                   .init(title: "Sea Beast", image: "Sea Beast", category: "Adventure", time: 144, rank: 4.4),
                   .init(title: "Luck", image: "Luck", category: "Mystery", time: 144, rank: 4)
        ])
    }()
    
    
    var pageData: [ListSection] {
        [poster, category, example]
    }
}
