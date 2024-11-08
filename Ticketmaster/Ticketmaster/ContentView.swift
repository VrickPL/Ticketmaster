//
//  ContentView.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State var url: URL? = nil

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            if let url = url {
                Text(url.absoluteString)
            }
        }
        .padding()
        .onAppear {
            do {
                url = try DefaultUrlBuilder.build(api: ApiConstructor(endpoint: Endpoint.events))
            } catch {
                
            }
        }
    }
}

#Preview {
    ContentView()
}
