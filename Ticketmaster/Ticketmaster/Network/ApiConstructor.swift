//
//  ApiConstructor.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import Foundation

typealias Parameters = [String: String]

struct ApiConstructor {
    let endpoint: Endpoint
    var parameters = Parameters()
}
