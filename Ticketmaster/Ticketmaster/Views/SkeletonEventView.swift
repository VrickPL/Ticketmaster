//
//  SkeletonEventView.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 08/11/2024.
//

import SwiftUI

struct SkeletonEventView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 250)
                .roundedCorner(12, corners: [.topLeft, .topRight])
            
            VStack(alignment: .leading, spacing: 8) {
                SkeletonTitleView()
                SkeletonTitleView()
                
                SkeletonInfoRowView(maxWidth: 150)
                SkeletonInfoRowView(maxWidth: 200)
                SkeletonInfoRowView(maxWidth: 120)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .opacity(isAnimating ? 0.6 : 1)
        .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
    }
    
    private struct SkeletonTitleView: View {
        var body: some View {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 25)
                .frame(maxWidth: .infinity)
        }
    }
    
    private struct SkeletonInfoRowView: View {
        let maxWidth: CGFloat
        
        var body: some View {
            HStack(spacing: 8) {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 20, height: 20)
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 20)
                    .frame(maxWidth: maxWidth)
            }
        }
    }
}

#Preview {
    SkeletonEventView()
}
