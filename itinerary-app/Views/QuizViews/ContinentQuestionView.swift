//
//  ContinentQuestionView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/2/23.
//
import SwiftUI

struct ContinentQuestionView: View {
    var quiz: Quiz
    
    @State private var selectedContinent = Quiz.Continent.northAmerica // Default selection
    

    var body: some View {
        ZStack {
            Color(.colorGreenMedium)
            VStack {
                Text("Select the continent you'd like to visit:")
                    .padding(.bottom, 10)
                Picker("Continent", selection: $selectedContinent) {
                    ForEach(Quiz.Continent.allCases, id: \.self) { continent in
                        Text(continent.rawValue).tag(continent)
                    }
                }
                .pickerStyle(.wheel) // You can use other styles as well

                NavigationLink(destination: WeatherQuestionView(quiz: quiz)) {
                    Button(action: {
                        quiz.continent = selectedContinent
                    }) {
                        Text("Next")
                    }
                }
            }
        }
    }
}
