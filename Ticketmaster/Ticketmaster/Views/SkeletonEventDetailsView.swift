//
//  SkeletonEventDetailsView.swift
//  Ticketmaster
//
//  Created by Jan Kazubski on 10/11/2024.
//

import SwiftUI

struct SkeletonEventDetailsView: View {
    @State private var isAnimating = false
    
    private var height: CGFloat {
        UIScreen.main.bounds.width * 2 / 3
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: height)
            
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    SkeletonTitleView(height: 40)
                        .frame(height: 50)
                    SkeletonTitleView()
                        .frame(height: 30)
                    SkeletonInfoRowView(maxWidth: 200)
                }
                
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 50)
                    .cornerRadius(30)
                
                VStack(alignment: .leading, spacing: 16) {
                    SkeletonTitleView()
                        .frame(height: 25)
                        .frame(maxWidth: 120)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(0..<4) { _ in
                            SkeletonInfoRowView(maxWidth: .random(in: 150...250))
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    SkeletonTitleView()
                        .frame(height: 25)
                        .frame(maxWidth: 120)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(0..<2) { _ in
                            SkeletonInfoRowView(maxWidth: .random(in: 150...250))
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    SkeletonTitleView()
                        .frame(height: 25)
                        .frame(maxWidth: 120)
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
        }
        .opacity(isAnimating ? 0.6 : 1)
        .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
    }
    
    private struct SkeletonTitleView: View {
        var height: CGFloat = 25

        var body: some View {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: height)
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
    SkeletonEventDetailsView()
}
