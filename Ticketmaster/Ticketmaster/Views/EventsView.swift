//
//  EventsView.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import SwiftUI

struct EventsView: View {
    @StateObject private var viewModel = EventsViewModel()
    @State private var showingSortOptions = false

    var body: some View {
        NavigationView {
            if let error = viewModel.error, viewModel.events.isEmpty {
                ErrorView(error: error, onButtonClick: fetchEvents)
            } else {
                List {
                    if viewModel.isLoading && viewModel.events.isEmpty {
                        ForEach(0..<5) { _ in
                            SkeletonEventView()
                                .listRowSeparator(.hidden)
                        }
                    } else {
                        ForEach(viewModel.events) { event in
                            EventRowView(event: event) {
                                if event.id == viewModel.events.last?.id {
                                    fetchNextPage()
                                }
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color(.systemBackground))
                        }
                        
                        if let error = viewModel.error {
                            ErrorView(error: error, onButtonClick: fetchEvents)
                        } else if viewModel.isLoading {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                    }
                }
                .listStyle(.inset)
                .refreshable {
                    refresh()
                }
                .navigationTitle("Events in Poland")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        SortMenuView(
                            onButtonClick: updateSort,
                            selectedOption: viewModel.selectedSort
                        )
                    }
                }
            }
        }
        .task {
            await viewModel.fetchEvents()
        }
    }
    
    private func fetchEvents() {
        Task {
            await viewModel.fetchEvents()
        }
    }
    
    private func fetchNextPage() {
        Task {
            await viewModel.fetchNextPage()
        }
    }
    
    private func refresh() {
        Task {
            await viewModel.refresh()
        }
    }
    
    private func updateSort(for sortOption: EventSortOption?) {
        Task {
            await viewModel.updateSort(for: sortOption)
        }
    }
    
    private struct EventRowView: View {
        let event: Event
        let onAppear: () -> Void
        
        var body: some View {
            ZStack {
                SingleEventView(event: event)
                    .onAppear(perform: onAppear)
                
                NavigationLink(destination: EventDetailsView(id: event.id)) {
                    EmptyView()
                }
                .opacity(0.0)
            }
        }
    }
    
    private struct SortMenuView: View {
        var onButtonClick: (EventSortOption?) -> Void
        var selectedOption: EventSortOption?

        var body: some View {
            Menu {
                ForEach(EventSortOption.allCases, id: \.self) { option in
                    Button {
                        if option != selectedOption {
                            onButtonClick(option)
                        } else {
                            onButtonClick(nil)
                        }
                    } label: {
                        HStack {
                            Text(option.displayName)
                            if selectedOption == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                Label("Sort", systemImage: "arrow.up.arrow.down")
            }
        }
    }
}

#Preview {
    EventsView()
}
