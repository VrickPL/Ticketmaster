//
//  EventDetails.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 09/11/2024.
//

import Foundation

// MARK: - EventDetails
struct EventDetails: Codable, Identifiable {
    let id: String
    let name: String
    let url: String
    let dates: Dates
    let embedded: EventDetailsEmbedded
    let classifications: [Classification]
    let priceRanges: [PriceRange]?
    let images: [ImageDecodable]
    let seatmap: Seatmap?
    
    enum CodingKeys: String, CodingKey {
        case name, id, url, dates, classifications, priceRanges, images, seatmap
        case embedded = "_embedded"
    }
}

// MARK: - needed structs
struct EventDetailsEmbedded: Codable {
    let venues: [Venue]
    let attractions: [Attraction]?
}

struct Attraction: Codable {
    let name: String
}

struct Classification: Codable {
    let genre: Genre
}

struct Genre: Codable {
    let name: String
}

struct PriceRange: Codable {
    let currency: String
    let min: Double
    let max: Double
}

struct Seatmap: Codable {
    let staticUrl: String
}

// MARK: - EventDetails extensions
extension EventDetails {
    var dateTime: String? {
        guard let localDate = dates.start.localDate, let localTime = dates.start.localTime else { return nil }
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm, dd.MM.yyyy"
        
        if let date = inputFormatter.date(from: "\(localDate)T\(localTime)Z") {
            return outputFormatter.string(from: date)
        }
        
        return nil
    }

    var city: String? { embedded.venues.first?.city.name }
    var country: String? { embedded.venues.first?.country.name }
    var venue: String? { embedded.venues.first?.name }
    var address: String? { embedded.venues.first?.address?.line1 }
    var genres: String? { classifications.compactMap{ $0.genre.name }.joined(separator: ", ") }
    var seatmapUrl: String? { seatmap?.staticUrl }
    var artist: String? { embedded.attractions?.first?.name }
    var priceRange: PriceRange? { priceRanges?.first }
}
