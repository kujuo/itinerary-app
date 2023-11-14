//
//  WeatherQuestionView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/2/23.
//

/*
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
} */

/*
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
                
                
                NavigationLink(destination: CityTypeView(quiz: quiz)) {
                    Text("Hot")
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
                })
                
                
            }
        }
        
    }
}
*/
// new code but need to make sure it updates weather correctly
import SwiftUI

struct WeatherQuestionView: View {
    var quiz: Quiz
    
    @State private var selectedWeather = Quiz.Weather.cold // Default selection
    
    var body: some View {
        ZStack {
            Color(.colorGreenMedium)
            VStack {
                Spacer()
                
                ZStack {
                    // Bigger rounded rectangle as a background with stroke
                        RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color.customLightTan.opacity(0.5))
                        .overlay(
                        RoundedRectangle(cornerRadius: 30)
                        .stroke(lineWidth: 2) // Adjust the thickness of the stroke
                        .foregroundColor(Color.customBlush) // Stroke color
                            .shadow(color: .customBlush.opacity(0.5), radius: 3, x:  2, y: 2)
                        )
                        .frame(width: 350, height: 150)
                     
                    // Text with thick rounded border
                    Text("What type of weather would you like?")
                        .font(.system(size: 20))
                        //.foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .fontWeight(.medium)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20) // Adjust corner radius as needed
                                .stroke(lineWidth: 1) // Adjust the thickness of the border
                                .foregroundColor(Color.customBlush) // Border color
                                .shadow(color: .customBlush, radius: 3, x:  2, y: 2)
                        )
                        .frame(width: 300, height: 100)
                    
                }
                Spacer()
               
                
                HStack {
                    ForEach(Quiz.Weather.allCases, id: \.self) { weatherType in
                        Button(action: {
                            selectedWeather = weatherType
                        }) {
                            Text(weatherType.rawValue)
                                .font(.title3)
                                .foregroundColor(selectedWeather == weatherType ? .white : .black)
                                .padding()
                                .background(selectedWeather == weatherType ? Color("AccentColor") : Color("ButtonBackground"))
                                .cornerRadius(10)
                        }
                    }
                    
                }
                Spacer()
                
                
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
                }
                .simultaneousGesture(TapGesture().onEnded {
                    quiz.weather = selectedWeather
                })
            }
        }
    }
}
