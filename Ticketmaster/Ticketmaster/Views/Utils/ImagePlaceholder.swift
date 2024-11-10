//
//  ImagePlaceholder.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 10/11/2024.
//

import SwiftUI

struct ImagePlaceholder: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray.opacity(0.2))
            
            ProgressView()
        }
    }
}

#Preview {
    ImagePlaceholder()
}
