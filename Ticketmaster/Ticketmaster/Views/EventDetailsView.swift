//
//  EventDetailsView.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 09/11/2024.
//

import SwiftUI

struct EventDetailsView: View {
    @StateObject private var viewModel: EventDetailsViewModel
    
    init(id: String) {
        _viewModel = StateObject(wrappedValue: EventDetailsViewModel(id: id))
    }
    
    var body: some View {
        VStack {
            Text(viewModel.event?.name ?? "brak")
        }
        .task {
            await viewModel.fetchEventDetails()
        }
    }
}

#Preview {
    EventDetailsView(id: "Z698xZQpZ16v-90S1o")
}
