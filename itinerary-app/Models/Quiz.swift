//
//  Quiz_to_Itineraries.swift
//  itinerary-app
//
//  Created by 叶志恒 on 11/9/23.
//

import Foundation
enum continents: String, Codable{
    case Asia
    case Africa
    case North_America
    case South_America
    case Europe
    case Antarctica
    case Australia
}

enum weathers: String, Codable{
    case hot
    case warm
    case cold
}

enum city_types: String, Codable{
    case modern
    case coastal
    case historical
}

struct QuizLocationAnswers{
    var continent: String
    var weather: String
    var type_of_city: String
    
    enum CodingKeys: String, CodingKey {
        case continent
        case weather
        case type_of_city
    }
}

struct QuizActivityAnswers{
    var location: String
    var activityTags: [String]
    var activitiesChosen: [Event]
    var foodTags:[String]
    
    enum CodingKeys: String, CodingKey {
        case location
        case activityTags
        case activitiesChosen
        case foodTags
    }
}


