//
//  ListSection.swift
//  SMovie
//
//  Created by Вова on 10.04.2023.
//

import Foundation

enum ListSection {
    case posters   ([ListItem])
    case categories([ListItem])
    case examples  ([ListItem])
    
    
    var items: ([ListItem]) {
        switch self {
        case .posters(let items),
             .categories(let items),
             .examples(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
    var title: String {
        switch self {
        case .posters(_):
            return ""
        case .categories(_):
            return "Category"
        case .examples(_):
            return "Box Office"
        }
    }
}
