//
//  NetworkService.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import Foundation

enum NetworkServiceError: Error {
    case invalidResponse
}

actor NetworkService {
    func fetchData<T: Decodable>(api: ApiConstructor) async throws -> T {
        let url = try DefaultUrlBuilder.build(api: api)
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200, response.statusCode < 300 else {
            throw NetworkServiceError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
