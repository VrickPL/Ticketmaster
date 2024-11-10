//
//  SplashScreen.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 10/11/2024.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false

        var body: some View {
            VStack {
                if isActive {
                    EventsView()
                } else {
                    VStack {
                        Image("Logo")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .clipShape(.circle)
                        Text("Ticketmaster")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Jan Kazubski")
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
                }
            }
        }
}

#Preview {
    SplashScreen()
}
