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
                    Text(event.name)
                        .onAppear {
                            if event.id == viewModel.events.last?.id {
                                Task {
                                    await viewModel.fetchNextPage()
                                }
                            }
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
            .refreshable {
                Task {
                    await viewModel.refresh()
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
