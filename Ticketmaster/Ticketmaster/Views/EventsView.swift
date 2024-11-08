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
            List(viewModel.events) { event in
                Text(event.name)
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
