//
//  GivenLocationView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/2/23.
//

import SwiftUI

struct GivenLocationView: View {
    var quiz: Quiz
    
    var body: some View {
        ZStack {
            Color(.colorGreenMedium)
            VStack {
                Text("Your location is:")
                    .padding(.bottom, 10)
            }
        }
    }
}
