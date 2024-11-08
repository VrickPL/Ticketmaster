//
//  Endpoint.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import Foundation

enum Endpoint {
    static let ticketmasterUrl = "https://app.ticketmaster.com/discovery/v2/events"
    
    case events, event(eventId: Int)
    
    private var path: String {
        return switch self {
        case .events:
            ""
        case .event(let eventId):
            "/\(eventId)"
        }
    }
    
    var fullPath: String {
        return Endpoint.ticketmasterUrl + path
    }
}
