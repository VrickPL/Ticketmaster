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
            List {
                if viewModel.isLoading && viewModel.events.isEmpty {
                    ForEach(0..<5) { _ in
                        SkeletonEventView()
                            .listRowSeparator(.hidden)
                    }
                } else {
                    ForEach(viewModel.events) { event in
                        SingleEventView(event: event)
                            .onAppear {
                                if event.id == viewModel.events.last?.id {
                                    Task {
                                        await viewModel.fetchNextPage()
                                    }
                                }
                            }
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .listStyle(.inset)
            .refreshable {
                Task {
                    await viewModel.refresh()
                }
            }
            .navigationTitle("Events in Poland")

            if viewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        .task {
            await viewModel.fetchEvents()
        }
    }
}

#Preview {
    EventsView()
}
