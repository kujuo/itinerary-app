//
//  ContinentQuestionView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/2/23.
//
import SwiftUI

struct ContinentQuestionView: View {
    var quiz: Quiz
    
    @State private var selectedContinent = Continent.northAmerica // Default selection
    

    var body: some View {
        ZStack {
            Color(.colorGreenMedium)
            VStack {
                Text("Select the continent you'd like to visit:")
                    .padding(.bottom, 10)
                Picker("Continent", selection: $selectedContinent) {
                    ForEach(Continent.allCases, id: \.self) { continent in
                        Text(continent.rawValue).tag(continent)
                    }
                }
                .pickerStyle(.wheel) // You can use other styles as well

              NavigationLink(destination: WeatherQuestionView(quiz: quiz)) {
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
                quiz.continent = selectedContinent
                quiz.continentMatchUpdate(continent: selectedContinent, points: 1)
              })
            }
        }
    }
}


