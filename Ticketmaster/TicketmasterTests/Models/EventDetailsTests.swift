//
//  EventDetailsTests.swift
//  TicketmasterTests
//
//  Created by Jan Kazubski on 10/11/2024.
//

import XCTest
@testable import Ticketmaster

final class EventDetailsTests: XCTestCase {
    // MARK: - basic json decoding
    func testEventDetailsDecoding() throws {
        let json = """
            {
                "id": "123",
                "name": "Concert",
                "url": "test.com",
                "dates": {
                    "start": {
                        "localDate": "2024-11-10",
                        "localTime": "20:30:00"
                    }
                },
                "_embedded": {
                    "venues": [{
                        "name": "PGE Narodowy",
                        "city": {
                            "name": "Warsaw"
                        },
                        "country": {
                            "name": "Poland"
                        },
                        "address": {
                            "line1": "Address"
                        }
                    }],
                    "attractions": [{
                        "name": "Quebonafide"
                    }]
                },
                "classifications": [{
                    "genre": {
                        "name": "Rap"
                    }
                }, {
                    "genre": {
                        "name": "Pop"
                    }
                }],
                "priceRanges": [{
                    "currency": "PLN",
                    "min": 100.0,
                    "max": 300.0
                }],
                "images": [{
                    "ratio": "16_9",
                    "url": "test.com/image1.jpg"
                }, {
                    "ratio": "4_3",
                    "url": "test.com/image2.jpg"
                }],
                "seatmap": {
                    "staticUrl": "test.com/seatmap.jpg"
                }
            }
            """
        
        let jsonData = json.data(using: .utf8)!
        let eventDetails = try JSONDecoder().decode(EventDetails.self, from: jsonData)
        
        XCTAssertEqual(eventDetails.id, "123")
        XCTAssertEqual(eventDetails.name, "Concert")
        XCTAssertEqual(eventDetails.url, "test.com")
        
        XCTAssertEqual(eventDetails.dates.start.localDate, "2024-11-10")
        XCTAssertEqual(eventDetails.dates.start.localTime, "20:30:00")
        
        XCTAssertEqual(eventDetails.embedded.venues.count, 1)
        XCTAssertEqual(eventDetails.embedded.venues.first?.name, "PGE Narodowy")
        XCTAssertEqual(eventDetails.embedded.venues.first?.city.name, "Warsaw")
        XCTAssertEqual(eventDetails.embedded.venues.first?.country.name, "Poland")
        XCTAssertEqual(eventDetails.embedded.venues.first?.address?.line1, "Address")
        
        XCTAssertEqual(eventDetails.embedded.attractions?.count, 1)
        XCTAssertEqual(eventDetails.embedded.attractions?.first?.name, "Quebonafide")
        
        XCTAssertEqual(eventDetails.classifications.count, 2)
        XCTAssertEqual(eventDetails.classifications[0].genre.name, "Rap")
        XCTAssertEqual(eventDetails.classifications[1].genre.name, "Pop")
        
        XCTAssertEqual(eventDetails.priceRanges?.count, 1)
        XCTAssertEqual(eventDetails.priceRanges?.first?.currency, "PLN")
        XCTAssertEqual(eventDetails.priceRanges?.first?.min, 100.0)
        XCTAssertEqual(eventDetails.priceRanges?.first?.max, 300.0)
        
        XCTAssertEqual(eventDetails.images.count, 2)
        XCTAssertEqual(eventDetails.images[0].ratio, "16_9")
        XCTAssertEqual(eventDetails.images[0].url, "test.com/image1.jpg")
        XCTAssertEqual(eventDetails.images[1].ratio, "4_3")
        XCTAssertEqual(eventDetails.images[1].url, "test.com/image2.jpg")
        
        XCTAssertEqual(eventDetails.seatmap?.staticUrl, "test.com/seatmap.jpg")
        
        XCTAssertEqual(eventDetails.city, "Warsaw")
        XCTAssertEqual(eventDetails.country, "Poland")
        XCTAssertEqual(eventDetails.venue, "PGE Narodowy")
        XCTAssertEqual(eventDetails.address, "Address")
        XCTAssertEqual(eventDetails.genres, "Rap, Pop")
        XCTAssertEqual(eventDetails.seatmapUrl, "test.com/seatmap.jpg")
        XCTAssertEqual(eventDetails.artist, "Quebonafide")
        XCTAssertEqual(eventDetails.dateTime, "20:30, 10.11.2024")
    }
    
    // MARK: - dateTime tests
    func testDateTimeFormatting() {
        XCTAssertEqual(eventDetails1.dateTime, "20:30, 10.11.2024")
    }
    
    func testDateTimeFormattingWithMissingTime() {
        let dates = Dates(start: Start(localDate: "2024-11-10", localTime: nil))
        let eventDetails = EventDetails(
            id: "123",
            name: "Event",
            url: "test.com",
            dates: dates,
            embedded: eventDetails1.embedded,
            classifications: [],
            priceRanges: nil,
            images: [],
            seatmap: nil
        )
        
        XCTAssertNil(eventDetails.dateTime)
    }
    
    func testDateTimeFormattingWithInvalidDate() {
        let dates = Dates(start: Start(localDate: "abcd", localTime: "20:00:00"))
        let eventDetails = EventDetails(
            id: "123",
            name: "Event",
            url: "test.com",
            dates: dates,
            embedded: eventDetails1.embedded,
            classifications: [],
            priceRanges: nil,
            images: [],
            seatmap: nil
        )
        
        XCTAssertNil(eventDetails.dateTime)
    }
    
    // MARK: - location tests
    func testLocationInformation() {
        XCTAssertEqual(eventDetails1.city, "City")
        XCTAssertEqual(eventDetails1.country, "Poland")
        XCTAssertEqual(eventDetails1.venue, "Venue")
        XCTAssertEqual(eventDetails1.address, "Street")
    }
    
    func testLocationInformationWithEmptyVenues() {
        let embedded = EventDetailsEmbedded(venues: [], attractions: nil)
        let eventDetails = EventDetails(
            id: "123",
            name: "Event",
            url: "test.com",
            dates: eventDetails1.dates,
            embedded: embedded,
            classifications: [],
            priceRanges: nil,
            images: [],
            seatmap: nil
        )
        
        XCTAssertNil(eventDetails.city)
        XCTAssertNil(eventDetails.country)
        XCTAssertNil(eventDetails.venue)
        XCTAssertNil(eventDetails.address)
    }
    
    // MARK: - genre tests
    func testGenres() {
        XCTAssertEqual(eventDetails1.genres, "Rap")
    }
    
    func testGenresWithMultipleClassifications() {
        let classifications = [
            Classification(genre: Genre(name: "Rock")),
            Classification(genre: Genre(name: "Pop"))
        ]
        let eventDetails = EventDetails(
            id: "123",
            name: "Event",
            url: "test.com",
            dates: eventDetails1.dates,
            embedded: eventDetails1.embedded,
            classifications: classifications,
            priceRanges: nil,
            images: [],
            seatmap: nil
        )
        
        XCTAssertEqual(eventDetails.genres, "Rock, Pop")
    }
    
    func testGenresWithEmptyClassifications() {
        let eventDetails = EventDetails(
            id: "123",
            name: "Event",
            url: "test.com",
            dates: eventDetails1.dates,
            embedded: eventDetails1.embedded,
            classifications: [],
            priceRanges: nil,
            images: [],
            seatmap: nil
        )
        
        XCTAssertEqual(eventDetails.genres, "")
    }
    
    // MARK: - priceRanges tests
    func testPriceRanges() {
        XCTAssertNotNil(eventDetails1.priceRange)
        XCTAssertEqual(eventDetails1.priceRange?.currency, "PLN")
        XCTAssertEqual(eventDetails1.priceRange?.min, 50)
        XCTAssertEqual(eventDetails1.priceRange?.max, 200)
    }
    
    func testPriceRangesWithNilValues() {
        let eventDetails = EventDetails(
            id: "123",
            name: "Event",
            url: "test.com",
            dates: eventDetails1.dates,
            embedded: eventDetails1.embedded,
            classifications: eventDetails1.classifications,
            priceRanges: nil,
            images: [],
            seatmap: nil
        )
        
        XCTAssertNil(eventDetails.priceRange)
        XCTAssertNil(eventDetails.priceRange?.currency)
        XCTAssertNil(eventDetails.priceRange?.min)
        XCTAssertNil(eventDetails.priceRange?.max)
    }
    
    // MARK: - EventDetails optional fields
    func testOptionalFields() {
        XCTAssertEqual(eventDetails1.seatmapUrl, "seatmap.jpg")
        XCTAssertEqual(eventDetails1.artist, "Artist")
        XCTAssertNotNil(eventDetails1.priceRanges)
    }
    
    func testOptionalFieldsWithNilValues() {
        let eventDetails = EventDetails(
            id: "123",
            name: "Event",
            url: "test.com",
            dates: eventDetails1.dates,
            embedded: EventDetailsEmbedded(venues: [], attractions: nil),
            classifications: [],
            priceRanges: nil,
            images: [],
            seatmap: nil
        )
        
        XCTAssertNil(eventDetails.seatmapUrl)
        XCTAssertNil(eventDetails.artist)
        XCTAssertNil(eventDetails.priceRanges)
    }
    
    // MARK: - EventDetails for testing
    private var eventDetails1: EventDetails {
        let dates = Dates(start: Start(localDate: "2024-11-10", localTime: "20:30:00"))
        let venue = Venue(
            name: "Venue",
            city: City(name: "City"),
            country: Country(name: "Poland"),
            address: Address(line1: "Street")
        )
        let attraction = Attraction(name: "Artist")
        let embedded = EventDetailsEmbedded(
            venues: [venue],
            attractions: [attraction]
        )
        let classification = Classification(genre: Genre(name: "Rap"))
        let priceRange = PriceRange(currency: "PLN", min: 50.0, max: 200.0)
        let image = ImageDecodable(ratio: "16_9", url: "image.jpg")
        let seatmap = Seatmap(staticUrl: "seatmap.jpg")
        
        return EventDetails(
            id: "123",
            name: "Event",
            url: "test.com",
            dates: dates,
            embedded: embedded,
            classifications: [classification],
            priceRanges: [priceRange],
            images: [image],
            seatmap: seatmap
        )
    }
}
