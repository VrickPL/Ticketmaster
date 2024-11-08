//
//  Event.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import Foundation

// MARK: - EventsResponse
struct EventsResponse: Codable {
    let page: Page
    let embedded: Embedded

    enum CodingKeys: String, CodingKey {
        case page
        case embedded = "_embedded"
    }
}

struct Page: Codable {
    let totalPages: Int
}

struct Embedded: Codable {
    let events: [Event]
}

// MARK: - Event
struct Event: Codable, Identifiable {
    let id: String
    let name: String
    let dates: Dates
    let place: Place?
    let images: [Image]?

    var date: String? { dates.start.localDate }
    var city: String? { place?.city.name }
    var venue: String? { place?.venue.name }
    var imageUrl: String? { images?.first?.url }
}

struct Dates: Codable {
    let start: Start
}

struct Start: Codable {
    let localDate: String?
}

struct Place: Codable {
    let city: City
    let venue: Venue
}

struct City: Codable {
    let name: String
}

struct Venue: Codable {
    let name: String
}

struct Image: Codable {
    let url: String
}
