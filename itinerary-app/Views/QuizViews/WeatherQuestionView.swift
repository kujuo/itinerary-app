//
//  WeatherQuestionView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/2/23.
//

import SwiftUI

struct WeatherQuestionView: View {
    var quiz: Quiz
    
    @State private var weather =  Quiz.Weather.cold
    @State private var selectedWeather = Quiz.Weather.cold // Default selection
    
    
    var body: some View {
        ZStack {
            Color(.colorGreenMedium)
            VStack {
                Text("What type of weather do you want? ")
                    .padding(.bottom, 10)
                Picker("Weather Type", selection: $selectedWeather) {
                    ForEach(Quiz.Weather.allCases, id: \.self) { weatherType in
                        Text(weatherType.rawValue).tag(weatherType)
                    }
                }
                .pickerStyle(.wheel) // You can use other styles as well
                
                Button {
                    quiz.weather = selectedWeather
                } label: {
                    NavigationLink(
                        destination: CityTypeView(quiz: quiz)
                    ) {
                        Text("Next")
                    }
                }
            }
        }
        
    }
}

