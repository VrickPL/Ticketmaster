//
//  NetworkServiceTests.swift
//  TicketmasterTests
//
//  Created by Jan Kazubski on 10/11/2024.
//

import XCTest
@testable import Ticketmaster

final class NetworkServiceTests: XCTestCase {
    // MARK: setting up
    var networkService: NetworkService!
    var mockSession: MockURLSession!
    let sampleUrl = "https://api.example.com"
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        networkService = NetworkService(session: mockSession)
    }
    
    // MARK: mocked structs
    struct MockURLSession: URLSessionProtocol {
        var mockData: Data?
        var mockResponse: URLResponse?
        var mockError: Error?
        
        func data(from url: URL) async throws -> (Data, URLResponse) {
            if let error = mockError {
                throw error
            }
            return (mockData ?? Data(), mockResponse ?? URLResponse())
        }
    }
    
    struct MockResponse: Codable {
        let id: String
        let name: String
    }
    
    struct MockEndpoint: EndpointProtocol {
        var fullPath: String
    }
    
    // MARK: unit tests
    func testSuccessfulDataFetch() async throws {
        let mockData = """
        {
            "id": "123",
            "name": "Event"
        }
        """.data(using: .utf8)!
        
        let mockResponse = HTTPURLResponse(
            url: URL(string: sampleUrl)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        mockSession.mockData = mockData
        mockSession.mockResponse = mockResponse
        
        let mockEndpoint = MockEndpoint(fullPath: sampleUrl)
        let mockApi = ApiConstructor(endpoint: mockEndpoint, parameters: [:])
        
        let result: MockResponse = try await networkService.fetchData(api: mockApi)
        
        XCTAssertEqual(result.id, "123")
        XCTAssertEqual(result.name, "Event")
    }
    
    func testInvalidApiKeyError() async {
        let mockResponse = HTTPURLResponse(
            url: URL(string: sampleUrl)!,
            statusCode: 401,
            httpVersion: nil,
            headerFields: nil
        )
        
        mockSession.mockData = Data()
        mockSession.mockResponse = mockResponse
        
        let mockEndpoint = MockEndpoint(fullPath: sampleUrl)
        let mockApi = ApiConstructor(endpoint: mockEndpoint, parameters: [:])
        
        do {
            let _: MockResponse = try await networkService.fetchData(api: mockApi)
            XCTFail("Expected invalidApiKey error")
        } catch let error as NetworkServiceError {
            XCTAssertEqual(error, NetworkServiceError.invalidApiKey)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testInvalidResponseError() async {
        let mockResponse = HTTPURLResponse(
            url: URL(string: sampleUrl)!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        
        mockSession.mockData = Data()
        mockSession.mockResponse = mockResponse
        
        let mockEndpoint = MockEndpoint(fullPath: sampleUrl)
        let mockApi = ApiConstructor(endpoint: mockEndpoint, parameters: [:])
        
        do {
            let _: MockResponse = try await networkService.fetchData(api: mockApi)
            XCTFail("Expected invalidResponse error")
        } catch let error as NetworkServiceError {
            XCTAssertEqual(error, NetworkServiceError.invalidResponse(statusCode: 500))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testDecodingError() async {
        let invalidJsonData = "invalid json".data(using: .utf8)!
        let mockResponse = HTTPURLResponse(
            url: URL(string: sampleUrl)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        mockSession.mockData = invalidJsonData
        mockSession.mockResponse = mockResponse
        
        let mockEndpoint = MockEndpoint(fullPath: sampleUrl)
        let mockApi = ApiConstructor(endpoint: mockEndpoint, parameters: [:])
        
        do {
            let _: MockResponse = try await networkService.fetchData(api: mockApi)
            XCTFail("Expected decoding error")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }
}
