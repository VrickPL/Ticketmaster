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
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var photoWidth: CGFloat {
        screenWidth * 9 / 10
    }
    
    private var photoHeight: CGFloat {
        photoWidth * 2 / 3
    }
    
    private var isDarkScheme: Bool {
        colorScheme == .dark
    }
    
    private var cardShadow: Color {
        isDarkScheme ? .white.opacity(0.05) : .black.opacity(0.1)
    }
    
    private var cardStrokeColor: Color {
        isDarkScheme ? Color.gray.opacity(0.2) : .clear
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let imageUrl = event.getImageUrl(for: "3_2") {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.2))
                        
                        ProgressView()
                    }
                }
                .frame(height: photoHeight)
                .clipped()
                .roundedCorner(12, corners: [.topLeft, .topRight])
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(event.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(2)
                
                if let date = event.date, !date.isEmpty {
                    Label {
                        Text(date)
                            .foregroundColor(.secondary)
                    } icon: {
                        Image(systemName: "calendar")
                            .foregroundColor(.primary)
                    }
                }
                
                if let venue = event.venue, !venue.isEmpty {
                    Label {
                        Text(venue)
                            .foregroundColor(.secondary)
                    } icon: {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.primary)
                    }
                }
                
                if let city = event.city, !city.isEmpty {
                    Label {
                        Text(city)
                            .foregroundColor(.secondary)
                    } icon: {
                        Image(systemName: "building.2")
                            .foregroundColor(.primary)
                    }
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
        dates: Dates(start: Start(localDate: "2024-11-09")),
        embedded: Embedded2(
            venues: [Venue(
                name: "Centrum Tradycji Hutnictwa",
                city: City(name: "Ostrowiec Świętokrzyski")
            )]
        ),
        images: [
            ImageDecodable(
                ratio: nil, url: "https://s1.ticketm.net/dam/a/0b0/250689a8-4025-4351-a91a-98038cfe60b0_TABLET_LANDSCAPE_3_2.jpg"
            )
        ]
    )
    )
}
