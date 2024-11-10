//
//  EventTests.swift
//  TicketmasterTests
//
//  Created by Jan Kazubski on 10/11/2024.
//

import XCTest
@testable import Ticketmaster

final class EventTests: XCTestCase {
    // MARK: - basic json decoding
    func testEventDecoding() throws {
        let json = """
            {
                "id": "123",
                "name": "Event",
                "dates": {
                    "start": {
                        "localDate": "2024-11-10",
                        "localTime": "20:00:00"
                    }
                },
                "_embedded": {
                    "venues": [{
                        "name": "Venue",
                        "city": {
                            "name": "City"
                        },
                        "country": {
                            "name": "Poland"
                        },
                        "address": {
                            "line1": "Street"
                        }
                    }]
                },
                "images": [
                    {
                        "ratio": "16_9",
                        "url": "test.com/image1.jpg"
                    },
                    {
                        "ratio": "4_3",
                        "url": "test.com/image2.jpg"
                    }
                ]
            }
            """
        
        let jsonData = json.data(using: .utf8)!
        let event = try JSONDecoder().decode(Event.self, from: jsonData)
        
        XCTAssertEqual(event.id, "123")
        XCTAssertEqual(event.name, "Event")
        XCTAssertEqual(event.dates.start.localDate, "2024-11-10")
        XCTAssertEqual(event.dates.start.localTime, "20:00:00")
        XCTAssertEqual(event.embedded?.venues?.first?.name, "Venue")
        XCTAssertEqual(event.embedded?.venues?.first?.city.name, "City")
        XCTAssertEqual(event.embedded?.venues?.first?.country.name, "Poland")
        XCTAssertEqual(event.embedded?.venues?.first?.address?.line1, "Street")
        XCTAssertEqual(event.images?.count, 2)
    }
    
    // MARK: - image ratio tests
    func testImageRatioMultipliers() {
        XCTAssertEqual(ImageRatio.ratio_16_9.multiplier, 9.0/16.0, accuracy: 0.001)
        XCTAssertEqual(ImageRatio.ratio_4_3.multiplier, 3.0/4.0, accuracy: 0.001)
        XCTAssertEqual(ImageRatio.ratio_3_2.multiplier, 2.0/3.0, accuracy: 0.001)
    }
    
    // MARK: - Event extension tests
    func testDateFormatting() {
        let start = Start(localDate: "2024-11-10", localTime: nil)
        let event = Event(id: "1", name: "Event", dates: Dates(start: start), embedded: nil, images: nil)
        
        XCTAssertEqual(event.date, "10.11.2024")
    }
    
    func testDateFormattingWithInvalidDate() {
        let start = Start(localDate: "abcd", localTime: nil)
        let event = Event(id: "1", name: "Event", dates: Dates(start: start), embedded: nil, images: nil)
        
        XCTAssertNil(event.date)
    }
    
    func testDateFormattingWithEmptyDate() {
        let start = Start(localDate: "", localTime: nil)
        let event = Event(id: "1", name: "Event", dates: Dates(start: start), embedded: nil, images: nil)
        
        XCTAssertNil(event.date)
    }
    
    func testDateFormattingWithNilDate() {
        let start = Start(localDate: nil, localTime: nil)
        let event = Event(id: "1", name: "Event", dates: Dates(start: start), embedded: nil, images: nil)
        
        XCTAssertNil(event.date)
    }
    
    func testVenueAndCityExtraction() {
        let venue = Venue(
            name: "Venue",
            city: City(name: "City"),
            country: Country(name: "Country"),
            address: nil
        )
        let event = Event(
            id: "1",
            name: "Event",
            dates: Dates(start: Start(localDate: nil, localTime: nil)),
            embedded: Embedded2(venues: [venue]),
            images: nil
        )
        
        XCTAssertEqual(event.venue, "Venue")
        XCTAssertEqual(event.city, "City")
    }
    
    func testVenueAndCityExtractionWithNoVenues() {
        let embedded2 = Embedded2(venues: [])
        let event = Event(
            id: "1",
            name: "Event",
            dates: Dates(start: Start(localDate: nil, localTime: nil)),
            embedded: embedded2,
            images: nil
        )
        
        XCTAssertNil(event.venue)
        XCTAssertNil(event.city)
    }
    
    func testVenueAndCityExtractionWithNoEmbedded() {
        let event = Event(
            id: "1",
            name: "Event",
            dates: Dates(start: Start(localDate: nil, localTime: nil)),
            embedded: nil,
            images: nil
        )
        
        XCTAssertNil(event.venue)
        XCTAssertNil(event.city)
    }
    
    // MARK: - Image tests
    func testGetImageWithSpecificRatio() {
        let images = [
            ImageDecodable(ratio: "16_9", url: "image1.jpg"),
            ImageDecodable(ratio: "4_3", url: "image2.jpg")
        ]
        let event = Event(
            id: "1",
            name: "Event",
            dates: Dates(start: Start(localDate: nil, localTime: nil)),
            embedded: nil,
            images: images
        )
        
        XCTAssertEqual(event.getImage(for: .ratio_16_9)?.url, "image1.jpg")
        XCTAssertEqual(event.getImage(for: .ratio_4_3)?.url, "image2.jpg")
    }
    
    func testGetDefaultImageWithNoRatioSpecified() {
        let images = [
            ImageDecodable(ratio: "16_9", url: "image1.jpg"),
            ImageDecodable(ratio: "4_3", url: "image2.jpg")
        ]
        let event = Event(
            id: "1",
            name: "Event",
            dates: Dates(start: Start(localDate: nil, localTime: nil)),
            embedded: nil,
            images: images
        )
        
        XCTAssertEqual(event.getImage()?.url, "image1.jpg")
    }
    
    func testGetImageWithNoImages() {
        let event = Event(
            id: "1",
            name: "Event",
            dates: Dates(start: Start(localDate: nil, localTime: nil)),
            embedded: nil,
            images: nil
        )
        
        XCTAssertNil(event.getImage(for: .ratio_16_9))
        XCTAssertNil(event.getImage())
    }
    
    // MARK: - ImageDecodable extension tests
    func testImageRatioConversion() {
        let image1 = ImageDecodable(ratio: "16_9", url: "test.jpg")
        XCTAssertEqual(image1.imageRatio, .ratio_16_9)
        
        let image2 = ImageDecodable(ratio: "abcd", url: "test.jpg")
        XCTAssertNil(image2.imageRatio)
        
        let image3 = ImageDecodable(ratio: "", url: "test.jpg")
        XCTAssertNil(image3.imageRatio)
        
        let image4 = ImageDecodable(ratio: nil, url: "test.jpg")
        XCTAssertNil(image4.imageRatio)
    }
}
