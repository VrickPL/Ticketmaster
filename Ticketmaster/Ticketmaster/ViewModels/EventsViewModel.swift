//
//  EventsViewModel.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import Foundation

@MainActor
class EventsViewModel: ObservableObject {
    private static let COUNTRY_CODE: String = "PL"

    private var currentPage = 0
    private var totalPages: Int?

    @Published var selectedSort: EventSortOption? = nil
    @Published var events: [Event] = []
    @Published var isLoading = false
    @Published var error: Error?

    func fetchEvents() async {
        if let totalPages = totalPages {
            guard currentPage < totalPages else { return }
        }
        
        isLoading = true
        defer { isLoading = false }

        do {
            var parameters = [
                "countryCode": EventsViewModel.COUNTRY_CODE,
                "page": String(currentPage)
            ]
            if let selectedSort = selectedSort {
                parameters["sort"] = selectedSort.rawValue
            }

            let apiConstructor = ApiConstructor(endpoint: Endpoint.events, parameters: parameters)
            let response: EventsResponse = try await NetworkManager.shared.fetchData(api: apiConstructor)
            
            self.totalPages = response.page.totalPages
            if currentPage == 0 {
                self.events = response.embedded.events
            } else {
                self.events.append(contentsOf: response.embedded.events)
            }
            
            self.error = nil
        } catch {
            self.error = error
        }
    }
    
    func fetchNextPage() async {
        self.currentPage += 1
        await fetchEvents()
    }
    
    func refresh() async {
        self.events = []
        self.currentPage = 0
        await fetchEvents()
    }
    
    func updateSort(for sortOption: EventSortOption?) async {
        self.selectedSort = sortOption
        await refresh()
    }
}
