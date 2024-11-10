//
//  EventDetailsView.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 09/11/2024.
//

import SwiftUI

struct EventDetailsView: View {
    @StateObject private var viewModel: EventDetailsViewModel
    
    private var height: CGFloat {
        UIScreen.main.bounds.width * 2 / 3
    }
    
    init(id: String) {
        _viewModel = StateObject(wrappedValue: EventDetailsViewModel(id: id))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let error = viewModel.error {
                    Text(error.localizedDescription)
                } else if let event = viewModel.event {
                    TabView {
                        ForEach(event.images, id: \.url) { image in
                            EventImageView(image: image, defaultHeight: height)
                        }
                    }
                    .tabViewStyle(.page)
                    .frame(height: height)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    
                    VStack(alignment: .leading, spacing: 24) {
                        GeneralInfoView(
                            name: event.name,
                            artist: event.artist,
                            dateTime: event.dateTime
                        )
                        
                        BuyTicketsButton(url: event.url)
                        
                        LocationView(
                            country: event.country,
                            city: event.city,
                            venue: event.venue,
                            address: event.address
                        )
                        
                        DetailsView(
                            genres: event.genres,
                            priceRanges: event.priceRanges?.first
                        )
                        
                        SeatedView(seatmapUrl: event.seatmapUrl)
                    }
                    .padding()
                }
            }
        }
        .background(Color(.systemBackground))
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchEventDetails()
        }
    }
    
    private struct GeneralInfoView: View {
        let name: String
        let artist: String?
        let dateTime: String?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                if let artist = artist {
                    Text(artist)
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                
                if let dateTime = dateTime {
                    InfoRow(icon: "calendar", text: dateTime)
                }
            }
        }
    }
    
    private struct LocationView: View {
        let country: String?
        let city: String?
        let venue: String?
        let address: String?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                if country != nil || city != nil || venue != nil || address != nil {
                    Text("Location")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
                if let country = country {
                    InfoRow(icon: "globe", text: country)
                }
                if let city = city {
                    InfoRow(icon: "building.2", text: city)
                }
                if let venue = venue {
                    InfoRow(icon: "building", text: venue)
                }
                if let address = address {
                    InfoRow(icon: "mappin.and.ellipse", text: address)
                }
            }
        }
    }
    
    private struct DetailsView: View {
        let genres: String?
        let priceRanges: PriceRange?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                if genres != nil || priceRanges != nil {
                    Text("Event Details")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
                if let genres = genres {
                    InfoRow(icon: "music.note", text: genres)
                }
                
                if let priceRange = priceRanges {
                    InfoRow(
                        icon: "ticket",
                        text: "Tickets from \(priceRange.currency) \(String(format: "%.2f", priceRange.min))"
                    )
                }
            }
        }
    }
    
    private struct SeatedView: View {
        let seatmapUrl: String?

        var body: some View {
            if let seatmapUrl = seatmapUrl {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Seating Plan")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    AsyncImage(url: URL(string: seatmapUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }
    }
    
    private struct BuyTicketsButton: View {
        let url: String

        var body: some View {
            Button {
                if let url = URL(string: url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } label: {
                Text("Buy tickets")
                    .font(.title3)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primary)
                    .foregroundStyle(Color(.systemBackground))
                    .cornerRadius(30)
            }
        }
    }
}

#Preview {
//    EventDetailsView(id: "Z698xZQpZ16v-90S1o")
    EventDetailsView(id: "Z698xZQpZaa3D")
}
