//
//  NetworkManager.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private let networkService = NetworkService()

    private init() {}

    func fetchData<T: Decodable>(api: ApiConstructor) async throws -> T {
        return try await networkService.fetchData(api: api)
    }
}
