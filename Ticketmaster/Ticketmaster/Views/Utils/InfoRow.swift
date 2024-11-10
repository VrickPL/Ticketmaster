//
//  InfoRow.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 10/11/2024.
//

import SwiftUI

struct InfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        Label {
            Text(text)
                .foregroundColor(.secondary)
        } icon: {
            Image(systemName: icon)
                .foregroundColor(.primary)
                .frame(width: 20)
                .imageScale(.medium)
        }
    }
}

#Preview {
    InfoRow(icon: "calendar", text: "11.11.2024")
}
