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
    let embedded: Embedded2?
    let images: [ImageDecodable]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dates
        case embedded = "_embedded"
        case images
    }

    var date: String? {
        guard let localDate = dates.start.localDate else { return nil }
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM.yyyy"
        
        if let date = inputFormatter.date(from: localDate) {
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    var city: String? { embedded?.venues.first?.city?.name }
    var venue: String? { embedded?.venues.first?.name }
    
    func getImageUrl(for ratio: String? = nil) -> String? {
        if let ratio = ratio, let image = images?.first(where: { $0.ratio == ratio }) {
            return image.url
        }
        
        return images?.first?.url
    }
}

struct Embedded2: Codable {
    let venues: [Venue]
}

struct Dates: Codable {
    let start: Start
}

struct Start: Codable {
    let localDate: String?
}

struct City: Codable {
    let name: String
}

struct Venue: Codable {
    let name: String?
    let city: City?
}

struct ImageDecodable: Codable {
    let ratio: String?
    let url: String
}
