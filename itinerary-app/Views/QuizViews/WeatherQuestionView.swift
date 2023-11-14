//
//  WeatherQuestionView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/2/23.
//

import SwiftUI

struct WeatherQuestionView: View {
    var quiz: Quiz
    
    @State private var weather = Weather.cold
    @State private var selectedWeather = Weather.cold // Default selection
    
    
    var body: some View {
        ZStack {
            Color(.colorGreenMedium)
            VStack {
                Text("What type of weather do you want? ")
                    .padding(.bottom, 10)
                Picker("Weather Type", selection: $selectedWeather) {
                    ForEach(Weather.allCases, id: \.self) { weatherType in
                        Text(weatherType.rawValue).tag(weatherType)
                    }
                }
                .pickerStyle(.wheel) // You can use other styles as well
                
              
              NavigationLink(destination: CityTypeView(quiz: quiz)) {
                  Text("Next")
                      .font(.subheadline)
                      .fontWeight(.medium)
                      .foregroundColor(.white)
                      .frame(maxWidth: .infinity)
                      .padding()
                      .background(Color("AccentColor"))
                      .cornerRadius(20)
                      .frame(width: 200, height: 300)
              }.simultaneousGesture(TapGesture().onEnded{
                quiz.weather = selectedWeather
                quiz.weatherMatchUpdate(weather: selectedWeather, points: 1)
              })

            }
        }
        
    }
}

