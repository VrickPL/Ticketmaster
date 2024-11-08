//
//  DefaultUrlBuilder.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import Foundation

enum DefaultUrlBuilderError: Error {
    case invalidPath, invalidUrl
}

enum DefaultUrlBuilder {
    static func build(api: ApiConstructor) throws -> URL {
        guard var urlComponentes = URLComponents(string: api.endpoint.fullPath) else {
            throw DefaultUrlBuilderError.invalidPath
        }

        urlComponentes.queryItems = buildQueryParams(api.parameters, ["api_key": NetworkKey.apiKey])
        guard let url = urlComponentes.url else {
            throw DefaultUrlBuilderError.invalidUrl
        }

        return url
    }

    static func buildQueryParams(_ params: Parameters...) -> [URLQueryItem] {
        params.flatMap { $0 }.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
    }
}
