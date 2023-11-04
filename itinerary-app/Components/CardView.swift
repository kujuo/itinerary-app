//
//  CardView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/4/23.
//


import SwiftUI

struct CardView: View {
    var body: some View {
        ZStack {
            CustomBackgroundView()
            
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(colors: [
                            .customBlush,
                            .customTan
                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .frame(width: 256, height: 256)
                Image("flight")
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(width: 320, height: 570)
    }
}
