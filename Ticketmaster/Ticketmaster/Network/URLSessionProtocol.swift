//
//  URLSessionProtocol.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 10/11/2024.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
