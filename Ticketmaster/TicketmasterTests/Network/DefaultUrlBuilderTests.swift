//
//  DefaultUrlBuilderTests.swift
//  TicketmasterTests
//
//  Created by Jan Kazubski on 10/11/2024.
//

import XCTest
@testable import Ticketmaster

final class DefaultUrlBuilderTests: XCTestCase {
    func testBuildUrlWithoutParams() throws {
        let endpoint = Endpoint.events
        let api = ApiConstructor(endpoint: endpoint, parameters: [:])
        
        let url = try DefaultUrlBuilder.build(api: api)
        
        XCTAssertEqual(
            url.absoluteString,
            "https://app.ticketmaster.com/discovery/v2/events?apikey=\(NetworkKey.apiKey)"
        )
    }

    func testBuildUrlWithOneParam() throws {
        let endpoint = Endpoint.events
        let params = ["param1": "value1"]
        let api = ApiConstructor(endpoint: endpoint, parameters: params)
        
        let url = try DefaultUrlBuilder.build(api: api)
        
        XCTAssertEqual(
            url.absoluteString,
            "https://app.ticketmaster.com/discovery/v2/events?param1=value1&apikey=\(NetworkKey.apiKey)"
        )
    }
    
    func testBuildUrlWithTwoParams() throws {
        let endpoint = Endpoint.events
        let params = [
            "param1": "value1",
            "param2": "value2"
        ]
        let api = ApiConstructor(endpoint: endpoint, parameters: params)
        
        let url = try DefaultUrlBuilder.build(api: api)
        
        XCTAssertEqual(
            url.absoluteString,
            "https://app.ticketmaster.com/discovery/v2/events?param1=value1&param2=value2&apikey=\(NetworkKey.apiKey)"
        )
    }
}
