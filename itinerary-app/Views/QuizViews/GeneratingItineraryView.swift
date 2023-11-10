//
//  GeneratingItineraryView.swift
//  itinerary-app
//
//  Created by jhou on 11/9/23.
//

import SwiftUI
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

func generateEvent_for_day(attraction_list: [String], geos_list: [String], restaurant_list: [String], daynumber: Int) -> Day{
    let Event1 = Event(id: UUID(), name: attraction_list[daynumber] , type: .attraction)
    let Event2 = Event(id: UUID(), name: geos_list[daynumber] , type: .geo)
    let Event3 = Event(id: UUID(), name: restaurant_list[daynumber] , type: .restaurant)
    
    let Dayplan = Day(id: UUID(), dayNumber: daynumber, events: [Event1, Event2, Event3])
    
    return Dayplan
}




func generate_itinerary(attrac: [String], geos: [String], restaurant: [String], daynumber: Int, location: String) -> Itinerary {
    var dayplan: [Day] = []
    for i in 0...daynumber {
        dayplan.append(generateEvent_for_day(attraction_list: attrac, geos_list: geos, restaurant_list: restaurant, daynumber: i))
    }
    let Itinerary = Itinerary(id: UUID(), location: location, isCurrent: false, days:dayplan,  lastEditDate: Date())
    return Itinerary
}


class DataManager {
    static let shared = DataManager() // Singleton instance
    private var listofid: [String] = [] // Private storage for IDs
    private var listofname: [String] = [] //Private storage for names
    
    
    private init() {} // Private initializer to ensure singleton usage
    
    func fetchAndStoreIDs(from urlString: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            completion(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: Invalid HTTP response")
                completion(false)
                return
            }

            guard let data = data else {
                print("Error: No data to decode")
                completion(false)
                return
            }

            guard let answer = try? JSONDecoder().decode(Answer.self, from: data) else {
                print("Error: Couldn't decode data into Answer")
                completion(false)
                return
            }

            self?.listofid.removeAll() // Clear any old IDs
            self?.listofname.removeAll()
            for location in answer.data {
                self?.listofid.append(location.id)
                self?.listofname.append(location.name)
            }
            
            completion(true) // Indicates success
        }
        
        task.resume() // Start the network request
    }
    
    // Function to retrieve stored IDs
    func getStoredIDs() -> [String] {
        return listofid
    }
    
    func getStoredNames() -> [String]{
        return listofname
    }
}


func generateEventList (bestDestination: CityDestination, category: Int) -> [String]{
    let key = "547B30F2C5CF4458B82FAC44F069D0FA"
    let latitude = String(bestDestination.latitude)
    let longtitude = String(bestDestination.longitude)
    let latlong = latitude + "," + longtitude
    if category == 1{
        let attractionsurl =
            "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=attractions&language=en"
        let semaphore1 = DispatchSemaphore(value: 0)
        
        var attractions: [String] = []
        // get the id list for all the attraction activities
        DataManager.shared.fetchAndStoreIDs(from: attractionsurl) { success in
            if success {
                let ids = DataManager.shared.getStoredIDs()
                
                // Now you have the IDs and can use them
                print("Stored IDs: \(ids)")
                let names = DataManager.shared.getStoredNames()
                print("Stored Names: \(names)")
                attractions = names
            } else {
                print("Failed to fetch IDs (attractions).")
            }
            semaphore1.signal()
        }
        semaphore1.wait() // Wait for the signal
        return attractions
    }
    else if category == 2{
        let geosurl =      "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=geos&language=en"
        var geos: [String] = []
        let semaphore2 = DispatchSemaphore(value: 0)
        DataManager.shared.fetchAndStoreIDs(from: geosurl) { success in
            if success {
                let ids = DataManager.shared.getStoredIDs()
                // Now you have the IDs and can use them
                print("Stored IDs: \(ids)")
                let names = DataManager.shared.getStoredNames()
                geos = names
                print("Stored Names: \(names)")
            } else {
                print("Failed to fetch IDs (geos).")
            }
            semaphore2.signal()
        }
        semaphore2.wait() // Wait for the signal
        return geos
    }
    else{
        let restauranturl = "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=restaurants&language=en"
        var restaurants: [String] = []
        let semaphore3 = DispatchSemaphore(value: 0)
        DataManager.shared.fetchAndStoreIDs(from: restauranturl) { success in
            if success {
                let ids = DataManager.shared.getStoredIDs()
                // Now you have the IDs and can use them
                print("Stored IDs: \(ids)")
                let names = DataManager.shared.getStoredNames()
                restaurants = names
                print("Stored Names: \(names)")
            } else {
                print("Failed to fetch IDs (restaurants).")
            }
            semaphore3.signal()
        }
        semaphore3.wait()
        return restaurants
    }
}



struct GeneratingItineraryView: View {
  @State private var itinerary: Itinerary? = nil
  var location: String
  var bestDestination: CityDestination
    var body: some View {
      VStack {
        let attractions = generateEventList(bestDestination: bestDestination, category: 1)
        let geos = generateEventList(bestDestination: bestDestination, category: 2)
        let restaurants = generateEventList(bestDestination: bestDestination, category: 3)
        
        let itinerary = generate_itinerary(attrac: attractions, geos: geos, restaurant: restaurants, daynumber: 3, location: location)
        
        let i = itinerary 
        
        Text("Itinerary Finished Generating!")
            .padding(.bottom, 10)
        Spacer()
//        Text(itinerary.days?[0].events?[0].name ?? "None")
        NavigationLink(destination: ItineraryDetailView(itinerary: itinerary, saved: false)) {
            Text("Next")
        }
//          Text(quiz_ans.continent)
//          Text(quiz.continent?.rawValue ?? "wrong").font(.title).bold()
//          Text(quiz_ans.weather)
//          Text(quiz.weather?.rawValue ?? "wrongweather")
        
        
      }
    }
}
