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
        VStack {
            List {
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
            .listStyle(.inset)
            .refreshable {
                Task {
                    await viewModel.refresh()
                }
            }

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
