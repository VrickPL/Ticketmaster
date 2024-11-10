//
//  EventSortOption.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 10/11/2024.
//

import Foundation

enum EventSortOption: String, CaseIterable {
    case dateAsc = "date,asc"
    case dateDesc = "date,desc"
    case nameAsc = "name,asc"
    case nameDesc = "name,desc"
    case random = "random"
    
    var displayName: String {
        switch self {
        case .dateAsc: return "Date (↓)"
        case .dateDesc: return "Date (↑)"
        case .nameAsc: return "Name (A-Z)"
        case .nameDesc: return "Name (Z-A)"
        case .random: return "Random"
        }
    }
}
