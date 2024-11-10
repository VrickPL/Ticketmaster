//
//  EndpointTests.swift
//  TicketmasterTests
//
//  Created by Jan Kazubski on 10/11/2024.
//

import XCTest
@testable import Ticketmaster

final class EndpointTests: XCTestCase {
    func testTicketmasterUrl() {
        XCTAssertEqual(Endpoint.ticketmasterUrl, "https://app.ticketmaster.com/discovery/v2/events")
    }
    
    func testEventsFullPath() {
        XCTAssertEqual(Endpoint.events.fullPath, "https://app.ticketmaster.com/discovery/v2/events")
    }
    
    func testEventDetailsFullPath() {
        XCTAssertEqual(Endpoint.event(eventId: "1a2b3c").fullPath, "https://app.ticketmaster.com/discovery/v2/events/1a2b3c")
    }
    
    func testEventDetailsFullPathEmptyId() {
        XCTAssertEqual(Endpoint.event(eventId: "").fullPath, "https://app.ticketmaster.com/discovery/v2/events/")
    }
}
