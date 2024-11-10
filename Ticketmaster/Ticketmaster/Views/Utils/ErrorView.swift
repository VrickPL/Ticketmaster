//
//  ErrorView.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 10/11/2024.
//

import SwiftUI

struct ErrorView: View {
    var error: Error? = nil
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
            
            if let error = error {
                Text(error.localizedDescription)
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    ErrorView(error: nil, onButtonClick: { })
}
