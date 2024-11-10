//
//  EventsView.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import SwiftUI

struct EventsView: View {
    @StateObject private var viewModel = EventsViewModel()

    var body: some View {
        NavigationView {
            if let error = viewModel.error, viewModel.events.isEmpty {
                ErrorView(error: error) {
                    fetchEvents()
                }
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
    
    private struct ErrorView: View {
        let error: Error
        var onButtonClick: () -> Void
        
        var body: some View {
            VStack {
                Spacer()
                Text("Oops, something went wrong!")
                    .font(.title3)

                Button("Try again") {
                    onButtonClick()
                }
                .foregroundStyle(.blue)
                .font(.title2)
                Spacer()
                
                Text(error.localizedDescription)
                    .foregroundStyle(.red)
            }
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
                }.opacity(0.0)
            }
        }
    }
}

#Preview {
    EventsView()
}
