//
//  EventDetailsViewModel.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 09/11/2024.
//

import Foundation

@MainActor
class EventDetailsViewModel: ObservableObject {
    let id: String

    @Published var event: EventDetails?
    @Published var isLoading = false
    @Published var error: Error?
    
    init(id: String) {
        self.id = id
    }

    func fetchEventDetails() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let parameters: [String: String] = [:]
            let apiConstructor = ApiConstructor(endpoint: Endpoint.event(eventId: id), parameters: parameters)
            let event: EventDetails = try await NetworkManager.shared.fetchData(api: apiConstructor)
            
            self.event = event
            self.error = nil
        } catch {
            self.error = error
        }
    }
    
    func refresh() async {
        self.event = nil
        await fetchEventDetails()
    }
}
