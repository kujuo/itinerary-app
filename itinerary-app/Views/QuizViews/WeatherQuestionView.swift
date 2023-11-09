//
//  WeatherQuestionView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/2/23.
//

import SwiftUI

struct WeatherQuestionView: View {
    var quiz: Quiz
    
    var body: some View {
        ZStack {
            Color(.colorGreenMedium)
            VStack {
                Text("What type of weather do you want? ")
                    .padding(.bottom, 10)
                NavigationLink(destination: CityTypeView(quiz: quiz)) {
                    Button(action: { }) {
                        Text("Next")
                    }
                }
            }
        }
    }
}
