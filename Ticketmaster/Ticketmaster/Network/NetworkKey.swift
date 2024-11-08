//
//  NetworkKey.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import Foundation

struct NetworkKey {
    static var apiKey: String {
        if let path = Bundle.main.path(forResource: "APIKeys", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path),
            let apiKey = try? PropertyListSerialization.propertyList(
                from: xml,
                format: nil
            ) as? [String: Any] {
            if let apiKey = apiKey["TICKETMASTER_API_KEY"] as? String {
                return apiKey
            }
        }

        return "YOUR_API_KEY"
    }
}
