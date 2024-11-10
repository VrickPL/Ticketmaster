//
//  EventSortOptionTests.swift
//  TicketmasterTests
//
//  Created by Jan Kazubski on 10/11/2024.
//

import XCTest
@testable import Ticketmaster

final class EventSortOptionTests: XCTestCase {
    func testRawValues() {
        XCTAssertEqual(EventSortOption.dateAsc.rawValue, "date,asc")
        XCTAssertEqual(EventSortOption.dateDesc.rawValue, "date,desc")
        XCTAssertEqual(EventSortOption.nameAsc.rawValue, "name,asc")
        XCTAssertEqual(EventSortOption.nameDesc.rawValue, "name,desc")
        XCTAssertEqual(EventSortOption.random.rawValue, "random")
    }
    
    func testDisplayNames() {
        XCTAssertEqual(EventSortOption.dateAsc.displayName, "Date (↓)")
        XCTAssertEqual(EventSortOption.dateDesc.displayName, "Date (↑)")
        XCTAssertEqual(EventSortOption.nameAsc.displayName, "Name (A-Z)")
        XCTAssertEqual(EventSortOption.nameDesc.displayName, "Name (Z-A)")
        XCTAssertEqual(EventSortOption.random.displayName, "Random")
    }
    
    func testCaseIterable() {
        let allCases = EventSortOption.allCases
        
        XCTAssertEqual(allCases.count, 5)
        XCTAssertTrue(allCases.contains(.dateAsc))
        XCTAssertTrue(allCases.contains(.dateDesc))
        XCTAssertTrue(allCases.contains(.nameAsc))
        XCTAssertTrue(allCases.contains(.nameDesc))
        XCTAssertTrue(allCases.contains(.random))
    }
}
