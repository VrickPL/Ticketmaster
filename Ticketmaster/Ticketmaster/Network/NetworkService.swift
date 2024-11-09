//
//  NetworkService.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import Foundation

enum NetworkServiceError: LocalizedError {
    case invalidResponse(statusCode: Int), invalidApiKey
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse(let statusCode):
            return "Invalid response from server (status code: \(statusCode))"
        case .invalidApiKey:
            return "Invalid ApiKey.\nPlease check your configuration in Ticketmaster/Network/NetworkKey.swift"
        }
    }
}

actor NetworkService {
    func fetchData<T: Decodable>(api: ApiConstructor) async throws -> T {
        let url = try DefaultUrlBuilder.build(api: api)
        let (data, response) = try await URLSession.shared.data(from: url)
        

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkServiceError.invalidResponse(statusCode: 0)
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return try JSONDecoder().decode(T.self, from: data)
        case 401:
            throw NetworkServiceError.invalidApiKey
        default:
            throw NetworkServiceError.invalidResponse(statusCode: httpResponse.statusCode)
        }
    }
}
