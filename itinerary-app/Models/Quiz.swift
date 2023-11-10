//
//  Quiz.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/1/23.
//

import Foundation
import SwiftUI

// should i create a question list or struct if i have a list would i just pass it into each of the structs?
// next button indicates the value that should be stored in that data structure
// or make it a global variable

// this is the struct for all answers after the location has been determined
/* struct QuizLocationAnswers {
    var continent: Continent
    var weather: Weather
    var city_type: City
}

// this is the struct for all answers after the location has been determined
struct QuizActivityAnswers {
    var location: String
    var activityTags: [String] = []
    var activitiesChosen: [Event] = []
    var foodTags: [String] = []
    var foodChosen: [Event] = []
}

enum Weather: String {
    case hot
    case cold
    case warm
}

enum Continent: String {
    case North_America
    case South_America
    case Africa
    case Asia
    case Antarctica
    case Europe
    case Australia
}

enum City: String {
    case island
    case metropolitan_city
    case desert
    case nature_reserve
    // add more cases
} */
struct QuizQuestion {
    let type: QuizQuestionType
    let question: String
    let answerChoices: [String]
}

// different types for the questions that have to do with location and then those that have to do with the activity tags and food
enum QuizQuestionType {
    case location
    case activity
}


//toString for view in city type
extension Quiz.City {
    func toString() -> String {
        switch self {
        case .desert:
            return "Desert"
        case .island:
            return "Island"
        case .natureReserve:
            return "Nature Reserve"
        case .metropolitanCity:
            return "Metropolitan City"
        case .modern: 
          return "Modern"
        case .historical:
          return "Historical"
        case .coastal: 
          return "Coastal"
        }
        
    }
}

// the questions variable will be an array of all the quiz questions since they wil always be the same
class Quiz {
    var questions: [QuizQuestion]? = []
    var duration: Int?
    var continent: Continent?
    var weather: Weather?
    var cityType: City?
    
    
    
    // these are the only options that a user can select for the continent
    enum Continent: String, CaseIterable {
        case northAmerica
        case southAmerica
        case africa
        case asia
        case antarctica
        case europe
        case australia
    }
    
    enum Weather: String, CaseIterable, Identifiable {
        case hot
        case warm
        case cold
        
        var id: String { rawValue }
    }
    
    enum City: String, CaseIterable, Identifiable {
        case modern
        case historical
        case coastal
        case island
        case metropolitanCity
        case desert
        case natureReserve
      

        var id: String { rawValue }
    }
    
}