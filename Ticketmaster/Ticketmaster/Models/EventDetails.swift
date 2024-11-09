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
    let dates: Dates
    let embedded: EmbeddedDetails?
    let images: [ImageDecodable]?
    let priceRanges: [PriceRange]?
    let classifications: [Classification]?
    let seatmap: Seatmap?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dates
        case embedded = "_embedded"
        case images
        case priceRanges = "price_ranges"
        case classifications
        case seatmap
    }

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

    var city: String? { embedded?.venues.first?.city?.name }
    var country: String? { embedded?.venues.first?.country?.name }
    var venue: String? { embedded?.venues.first?.name }
    var address: String? { embedded?.venues.first?.address?.line1 }
    var genre: String? { classifications?.first?.genre?.name }
    var seatmapUrl: String? { seatmap?.staticUrl }
    
    func getImageUrl(for ratio: String? = nil) -> String? {
        if let ratio = ratio, let image = images?.first(where: { $0.ratio == ratio }) {
            return image.url
        }
        
        return images?.first?.url
    }
}

// MARK: - EmbeddedDetails
struct EmbeddedDetails: Codable {
    let venues: [VenueDetails]
}

// MARK: - VenueDetails
struct VenueDetails: Codable {
    let name: String?
    let city: City?
    let country: Country?
    let address: Address?
    
    enum CodingKeys: String, CodingKey {
        case name
        case city
        case country
        case address
    }
}

// MARK: - Address
struct Address: Codable {
    let line1: String?
}

// MARK: - Country
struct Country: Codable {
    let name: String
}

// MARK: - PriceRange
struct PriceRange: Codable {
    let min: Double
    let currency: String
}

// MARK: - Classification
struct Classification: Codable {
    let genre: Genre?
}

// MARK: - Genre
struct Genre: Codable {
    let name: String
}

// MARK: - Seatmap
struct Seatmap: Codable {
    let staticUrl: String
    
    enum CodingKeys: String, CodingKey {
        case staticUrl = "static_url"
    }
}
