//
//  quiz_2_itinerary.swift
//  itinerary-app
//
//  Created by 叶志恒 on 11/9/23.
//

import Foundation
struct CityDestination {
    var name: String
    var latitude: Double
    var longitude: Double
    var weather: String
    var cityTypes: [String]
    var continent: String
}




let cityDestinations = [
    CityDestination(name: "Paris", latitude: 48.8566, longitude: 2.3522, weather: "warm", cityTypes: ["modern", "historical"], continent: "Europe"),
    CityDestination(name: "Cairo", latitude: 30.0444, longitude: 31.2357, weather: "hot", cityTypes: ["historical"], continent: "Africa"),
    CityDestination(name: "New York", latitude: 40.7128, longitude: -74.0060, weather: "warm", cityTypes: ["modern", "coastal"], continent: "North America"),
    CityDestination(name: "Tokyo", latitude: 35.6895, longitude: 139.6917, weather: "warm", cityTypes: ["modern", "coastal"], continent: "Asia"),
    CityDestination(name: "Sydney", latitude: -33.8688, longitude: 151.2093, weather: "warm", cityTypes: ["modern", "coastal"], continent: "Australia"),
    CityDestination(name: "Rio de Janeiro", latitude: -22.9068, longitude: -43.1729, weather: "hot", cityTypes: ["coastal"], continent: "South America"),
    CityDestination(name: "Moscow", latitude: 55.7558, longitude: 37.6173, weather: "cold", cityTypes: ["modern", "historical"], continent: "Europe"),
    CityDestination(name: "Cape Town", latitude: -33.9249, longitude: 18.4241, weather: "warm", cityTypes: ["coastal", "historical"], continent: "Africa"),
    CityDestination(name: "London", latitude: 51.5074, longitude: -0.1278, weather: "cold", cityTypes: ["modern", "historical"], continent: "Europe"),
    CityDestination(name: "Vancouver", latitude: 49.2827, longitude: -123.1207, weather: "cold", cityTypes: ["modern", "coastal"], continent: "North America")
]



// Function to find the best matching city destination based on quiz results
func findBestDestination(for quizResult: Quiz, from cityDestinations: [CityDestination]) -> CityDestination? {
    // Filter the destinations based on the continent
  let continentMatchedDestinations = cityDestinations.filter { $0.continent == quizResult.continent?.rawValue }
    
    // Filter the destinations based on the weather
  let weatherMatchedDestinations = continentMatchedDestinations.filter { $0.weather == quizResult.weather?.rawValue }
    
    // Filter the destinations based on the city type
    // Since cityTypes is an array, we check if the array contains the quiz result's typeOfCity
  let typeMatchedDestinations = weatherMatchedDestinations.filter { $0.cityTypes.contains(quizResult.cityType?.rawValue ?? "historical") }
    
    // Return the first destination that matches all criteria, or nil if there's no match
    return typeMatchedDestinations.first
}



// testing for the findDestination // For Playground Only
//let quizResult = QuizLocationAnswers(continent: "Asia", weather: "warm", type_of_city: "modern")

//if let bestDestination = findBestDestination(for: quizResult, from: cityDestinations) {
    //print("The best destination for you is: \(bestDestination.name)")
//} else {
 //   print("We could not find a destination that matches all your preferences.")
//}


