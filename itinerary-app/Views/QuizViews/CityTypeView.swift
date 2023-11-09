//
//  CityTypeView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/2/23.
//

import SwiftUI

struct CityTypeView: View {
    var quiz: Quiz
    
    var body: some View {
        ZStack {
            Color(.colorGreenMedium)
            VStack {
                Text("Click the picture that represents the type of city you would like to go to:")
                    .padding(.bottom, 10)
                NavigationLink(destination: GivenLocationView(quiz: quiz)) {
                    Button(action: { }) {
                        Text("Next")
                    }
                }
            }
        }
    }
}
