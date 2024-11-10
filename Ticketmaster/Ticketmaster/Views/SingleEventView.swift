//
//  SingleEventView.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import SwiftUI

struct SingleEventView: View {
    @Environment(\.colorScheme) var colorScheme
    let event: Event
    
    private var isDarkScheme: Bool {
        colorScheme == .dark
    }
    
    private var cardShadow: Color {
        isDarkScheme ? .white.opacity(0.05) : .black.opacity(0.1)
    }
    
    private var cardStrokeColor: Color {
        isDarkScheme ? Color.gray.opacity(0.2) : .clear
    }
    
    private var imageHeight: CGFloat {
        UIScreen.main.bounds.width * 3 / 5
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            EventImageView(
                image: event.getImage(for: ImageRatio.ratio_3_2),
                defaultHeight: imageHeight,
                roundedTopCorners: true,
                multiplier: 0.9
            )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(event.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(2)
                
                if let date = event.date, !date.isEmpty {
                    InfoRow(icon: "calendar", text: date)
                }
                
                if let venue = event.venue, !venue.isEmpty {
                    InfoRow(icon: "mappin.and.ellipse", text: venue)
                }
                
                if let city = event.city, !city.isEmpty {
                    InfoRow(icon: "building.2", text: city)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: cardShadow, radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(cardStrokeColor, lineWidth: 1)
        )
    }
}

#Preview {
    SingleEventView(event: Event(
        id: "Z698xZQpZ16v-90S1o",
        name: "Rafał Pacześ - ProkuraTOUR'a - nowy program Stand-UP",
        dates: Dates(start: Start(localDate: "2024-11-09", localTime: nil)),
        embedded: Embedded2(
            venues: [Venue(
                name: "Centrum Tradycji Hutnictwa",
                city: City(name: "Ostrowiec Świętokrzyski"),
                country: Country(name: "Poland"),
                address: Address(line1: "")
            )]
        ),
        images: [
            ImageDecodable(
                ratio: nil,
                url: "https://s1.ticketm.net/dam/a/0b0/250689a8-4025-4351-a91a-98038cfe60b0_TABLET_LANDSCAPE_3_2.jpg"
            )
        ]
    )
    )
}
