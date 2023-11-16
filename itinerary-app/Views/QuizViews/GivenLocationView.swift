//
//  GivenLocationView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/2/23.
//

import SwiftUI

struct QuizLocationAnswers{
    var continent: String
    var weather: String
    var type_of_city: String
    var duration: Int
    
    enum CodingKeys: String, CodingKey {
        case continent
        case weather
        case type_of_city
    }
}

//struct CityDestination {
//    var name: String
//    var latitude: Double
//    var longitude: Double
//    var weather: String
//    var cityTypes: [String]
//    var continent: String
//}


func findBestDestination(for quizResult: QuizLocationAnswers, from cityDestinations: [CityDestination]) -> CityDestination? {
    // Filter the destinations based on the continent
    let continentMatchedDestinations = cityDestinations.filter { $0.continent == quizResult.continent }
    
    // Filter the destinations based on the weather
    let weatherMatchedDestinations = continentMatchedDestinations.filter { $0.weather == quizResult.weather }
    
    // Filter the destinations based on the city type
    // Since cityTypes is an array, we check if the array contains the quiz result's typeOfCity
    let typeMatchedDestinations = weatherMatchedDestinations.filter { $0.cityType.contains(quizResult.type_of_city) }
    
    // Return the first destination that matches all criteria, or nil if there's no match
    return typeMatchedDestinations.first
}

let cityDestinations = [
  CityDestination(name: "Paris", latitude: 48.8566, longitude: 2.3522, weather: "warm", cityType: ["modern", "historical"], continent: "Europe"),
  CityDestination(name: "Cairo", latitude: 30.0444, longitude: 31.2357, weather: "hot", cityType: ["historical"], continent: "Africa"),
  CityDestination(name: "New York", latitude: 40.7128, longitude: -74.0060, weather: "warm", cityType: ["modern", "coastal"], continent: "North America"),
  CityDestination(name: "Tokyo", latitude: 35.6895, longitude: 139.6917, weather: "warm", cityType: ["modern", "coastal"], continent: "Asia"),
  CityDestination(name: "Sydney", latitude: -33.8688, longitude: 151.2093, weather: "warm", cityType: ["modern", "coastal"], continent: "Australia"),
  CityDestination(name: "Rio de Janeiro", latitude: -22.9068, longitude: -43.1729, weather: "hot", cityType: ["coastal"], continent: "South America"),
  CityDestination(name: "Moscow", latitude: 55.7558, longitude: 37.6173, weather: "cold", cityType: ["modern", "historical"], continent: "Europe"),
  CityDestination(name: "Cape Town", latitude: -33.9249, longitude: 18.4241, weather: "warm", cityType: ["coastal", "historical"], continent: "Africa"),
  CityDestination(name: "London", latitude: 51.5074, longitude: -0.1278, weather: "cold", cityType: ["modern", "historical"], continent: "Europe"),
  CityDestination(name: "Vancouver", latitude: 49.2827, longitude: -123.1207, weather: "cold", cityType: ["modern", "coastal"], continent: "North America")
]




struct GivenLocationView: View {
    var quiz: Quiz

    var body: some View {
        let bestDestination = quiz.getBestDestination()

        ZStack {
            Image("flight2")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            // Move the text and button outside of the VStack
            Text("Your location is:")
                .font(.system(size: 40, weight: .semibold))
                .foregroundColor(.white)
                .padding(.bottom, 60)

            Text(bestDestination?.name ?? "")
                .font(.system(size: 40, weight: .semibold))
                .foregroundColor(.white)
                .padding(.top, 25)

            if let bestDestination {
                NavigationLink(destination: GeneratingItineraryView(location: bestDestination.name, bestDestination: bestDestination)) {
                    HStack {
                        Spacer()
                        Text("Next")
                            .font(.subheadline)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("AccentColor"))
                            .cornerRadius(20)
                            .frame(width: 100, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            .padding()
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
}

