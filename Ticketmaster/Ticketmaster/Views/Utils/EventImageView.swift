//
//  EventImageView.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 10/11/2024.
//

import SwiftUI

struct EventImageView: View {
    let image: ImageDecodable?
    let defaultHeight: CGFloat
    var roundedTopCorners = false
    var multiplier = 1.0
    
    var height: CGFloat {
        if let ratioMultiplier = image?.imageRatio?.multiplier {
            UIScreen.main.bounds.width * ratioMultiplier * multiplier
        } else {
            defaultHeight
        }
    }
    
    var body: some View {
        VStack {
            if let image = image {
                AsyncImage(url: URL(string: image.url)) { image in
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
        .roundedCorner(roundedTopCorners ? 12 : 0, corners: [.topLeft, .topRight])
    }
}

#Preview {
    EventImageView(
        image: ImageDecodable(
            ratio: "3_2",
            url: "https://s1.ticketm.net/dam/a/0b0/250689a8-4025-4351-a91a-98038cfe60b0_TABLET_LANDSCAPE_3_2.jpg"
        ),
        defaultHeight: 250
    )
}
