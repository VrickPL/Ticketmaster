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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            EventImageView(imageUrl: event.getImageUrl(for: "3_2"))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(event.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(2)
                
                if let date = event.date, !date.isEmpty {
                    EventInfoRow(icon: "calendar", text: date)
                }
                
                if let venue = event.venue, !venue.isEmpty {
                    EventInfoRow(icon: "mappin.and.ellipse", text: venue)
                }
                
                if let city = event.city, !city.isEmpty {
                    EventInfoRow(icon: "building.2", text: city)
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
    
    private struct EventImageView: View {
        let imageUrl: String?
        
        private var screenWidth: CGFloat {
            UIScreen.main.bounds.width
        }
        
        private var height: CGFloat {
            screenWidth * 3 / 5
        }
        
        var body: some View {
            VStack {
                if let imageUrl = imageUrl {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ImagePlaceholder()
                    }
                } else {
                    ImagePlaceholder()
                }
            }
            .frame(height: height)
            .clipped()
            .roundedCorner(12, corners: [.topLeft, .topRight])
        }
        
        private struct ImagePlaceholder: View {
            var body: some View {
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.2))
                    
                    ProgressView()
                }
            }
        }
    }
    
    private struct EventInfoRow: View {
        let icon: String
        let text: String
        
        var body: some View {
            Label {
                Text(text)
                    .foregroundColor(.secondary)
            } icon: {
                Image(systemName: icon)
                    .foregroundColor(.primary)
            }
        }
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
