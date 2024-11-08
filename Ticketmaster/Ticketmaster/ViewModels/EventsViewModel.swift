//
//  EventsViewModel.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import Foundation

@MainActor
class EventsViewModel: ObservableObject {
    private var currentPage = 0
    private var totalPages: Int?

    @Published var events: [Event] = []

    func fetchEvents() async {
        if let totalPages = totalPages {
            guard currentPage < totalPages else { return }
        }

        do {
            let parameters = ["page": String(currentPage)]
            let apiConstructor = ApiConstructor(endpoint: Endpoint.events, parameters: parameters)
            let response: EventsResponse = try await NetworkManager.shared.fetchData(api: apiConstructor)
            
            self.totalPages = response.page.totalPages
            self.events = response.embedded.events
        } catch {
            //TODO: error handling
            print(error.localizedDescription)
        }
    }
    
    func fetchNextPage() async {
        currentPage += 1
        await fetchEvents()
    }
    
    func refresh() async {
        currentPage = 0
        await fetchEvents()
    }
}
