import Foundation
import SwiftUI
//import PlaygroundSupport
//PlaygroundPage.current.needsIndefiniteExecution = true


// built-in structs
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

enum EventType: String, Codable {
    case meal
    case attraction
    case travel
}

struct Event: Identifiable, Codable {
  
  var id: UUID
  var name: String
  var description: String?
  var img: String?
  var type: EventType
  var latitude: Double?
  var longitude: Double?
  var timeStart: String?
  var timeEnd: String?
  var url: String?
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case img
    case type
    case latitude
    case longitude
    case timeStart
    case timeEnd
    case url
  }
}

struct Day: Identifiable, Codable {
  
  var id: UUID
  var dayNumber: Int
  var events: [Event]?
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case dayNumber
    case events
  }
}

struct Itinerary: Identifiable, Codable, Comparable {
  
  var id: UUID
  var location: String
  var img: String?
  var isCurrent: Bool
  var days: [Day]?
  var lastEditDate: Date
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case location
    case img
    case isCurrent
    case days
    case lastEditDate
  }
  
  static func < (lhs: Itinerary, rhs: Itinerary) -> Bool {
    lhs.lastEditDate < rhs.lastEditDate
  }
  
  static func == (lhs: Itinerary, rhs: Itinerary) -> Bool {
    lhs.lastEditDate == rhs.lastEditDate
  }
}



// structs required by algorithm / api calls
struct CityDestination {
    var name: String
    var latitude: Double
    var longitude: Double
    var weather: String
    var cityTypes: [String]
    var continent: String
}


// structs for api calls
struct Answer: Decodable{
  let data: [Location]
  
  enum CodingKeys: String, CodingKey{
    case data = "data"
  }
}

struct Location: Decodable {
  let id: String
  let name: String
  let address: Address
  
  enum CodingKeys: String, CodingKey {
    case id = "location_id"
    case name = "name"
    case address = "address_obj"
  }
}

struct Address: Decodable{
  let street1: String?
  let street2: String?
  let city: String?
  let state: String?
  let country: String
  let address_string: String
  
  enum CodingKeys: String, CodingKey{
    case street1 = "street1"
    case street2 = "street2"
    case city = "city"
    case state = "state"
    case country = "country"
    case address_string = "address_string"
  }
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

func findBestDestination(for quizResult: QuizLocationAnswers, from cityDestinations: [CityDestination]) -> CityDestination? {
    // Filter the destinations based on the continent
    let continentMatchedDestinations = cityDestinations.filter { $0.continent == quizResult.continent }
    
    // Filter the destinations based on the weather
    let weatherMatchedDestinations = continentMatchedDestinations.filter { $0.weather == quizResult.weather }
    
    // Filter the destinations based on the city type
    // Since cityTypes is an array, we check if the array contains the quiz result's typeOfCity
    let typeMatchedDestinations = weatherMatchedDestinations.filter { $0.cityTypes.contains(quizResult.type_of_city) }
    
    // Return the first destination that matches all criteria, or nil if there's no match
    return typeMatchedDestinations.first
}


let quizResult = QuizLocationAnswers(continent: "Europe", weather: "cold", type_of_city: "modern")

if let bestDestination = findBestDestination(for: quizResult, from: cityDestinations) {
    print(bestDestination.latitude)
    print(bestDestination.longitude)
    print("The best destination for you is: \(bestDestination.name)")
    
    let key = "547B30F2C5CF4458B82FAC44F069D0FA"
    let latitude = String(bestDestination.latitude)
    let longtitude = String(bestDestination.longitude)
    let latlong = latitude + "," + longtitude
    
    let basicqueryurl = "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&language=en"
    
    let attractionsurl =
        "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=attractions&language=en"
    
    let geosurl =      "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=geos&language=en"
    
    let restauranturl = "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=restaurants&language=en"
    
    // get the id list for all the attraction activities
    var attraction_list: [String] = []
    let task_attraction = URLSession.shared.dataTask(with: URL(string: attractionsurl)!) { (data, response, error) in
        guard let data = data else {
          print("Error: No data to decode")
          return
        }
    

        guard let answer = try? JSONDecoder().decode(Answer.self, from: data) else {
          print("Error: Couldn't decode data into a result")
          return
        }
        

            
        for location in answer.data {
          attraction_list.append(location.id)
            print(attraction_list)
          //print("The \(location.name) 's id is \(location.id)")
        }
        //print(attraction_list)
        //print("--------------------------------------------------------------------")
    }
    
    task_attraction.resume()
    
    var geos_list: [String] = []
    let task_geos = URLSession.shared.dataTask(with: URL(string: geosurl)!) { (data, response, error) in
        guard let data = data else {
          print("Error: No data to decode")
          return
        }
        
        guard let answer = try? JSONDecoder().decode(Answer.self, from: data) else {
          print("Error: Couldn't decode data into a result")
          return
        }
        

            
        for location in answer.data {
            geos_list.append(location.id)
            print(geos_list)
          //print("The \(location.name) 's id is \(location.id)")
        }
        //print(attraction_list)
        //print("--------------------------------------------------------------------")
    }
    
    task_geos.resume()
    
    var rest_list: [String] = []
    let task_rests = URLSession.shared.dataTask(with: URL(string: restauranturl)!) { (data, response, error) in
        guard let data = data else {
          print("Error: No data to decode")
          return
        }

        guard let answer = try? JSONDecoder().decode(Answer.self, from: data) else {
          print("Error: Couldn't decode data into a result")
          return
        }
        

            
        for location in answer.data {
            rest_list.append(location.id)
            print(rest_list)
          //print("The \(location.name) 's id is \(location.id)")
        }
        //print(attraction_list)
        //print("--------------------------------------------------------------------")
    }
    
    task_rests.resume()
    
    
    
} else {
    print("We could not find a destination that matches all your preferences.")
}




