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
}

// MARK: - needed structs
struct Embedded2: Codable {
    let venues: [Venue]?
}

struct Dates: Codable {
    let start: Start
}

struct Start: Codable {
    let localDate: String?
    let localTime: String?
}

struct City: Codable {
    let name: String
}

struct Venue: Codable {
    let name: String
    let city: City
    let country: Country
    let address: Address?
}

struct Country: Codable {
    let name: String
}

struct Address: Codable {
    let line1: String
}

struct ImageDecodable: Codable {
    let ratio: String?
    let url: String
}

enum ImageRatio: String {
    case ratio_16_9 = "16_9"
    case ratio_4_3 = "4_3"
    case ratio_3_2 = "3_2"
    
    var multiplier: CGFloat {
        switch self {
        case .ratio_16_9: return 9 / 16
        case .ratio_4_3: return 3 / 4
        case .ratio_3_2: return 2 / 3
        }
    }
}

// MARK: - Event extensions
extension Event {
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
    var city: String? { embedded?.venues?.first?.city.name }
    var venue: String? { embedded?.venues?.first?.name }
    
    func getImage(for ratio: ImageRatio? = nil) -> ImageDecodable? {
        if let ratio = ratio, let image = images?.first(where: { $0.imageRatio == ratio }) {
            return image
        }
        
        return images?.first
    }
}

extension ImageDecodable {
    var imageRatio: ImageRatio? {
        if let ratio = self.ratio {
            return ImageRatio(rawValue: ratio)
        }
        
        return nil
    }
}
