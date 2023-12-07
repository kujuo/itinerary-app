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

//structures for fetching images:
struct Root: Decodable {
    let data: [DataItem]
}

// Data item structure
struct DataItem: Decodable {
    let id: Int
    let isBlessed: Bool
    let caption: String
    let publishedDate: String
    let images: Images
    let album: String
    let source: Source
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case isBlessed = "is_blessed"
        case caption
        case publishedDate = "published_date"
        case images
        case album
        case source
        case user
    }
}

// Images structure
struct Images: Decodable {
    let thumbnail: ImageSize
    let small: ImageSize
    let medium: ImageSize
    let large: ImageSize
    let original: ImageSize
}

// Image size structure
struct ImageSize: Decodable {
    let height: Int
    let width: Int
    let url: String
}

// Source structure
struct Source: Decodable {
    let name: String
    let localizedName: String

    enum CodingKeys: String, CodingKey {
        case name
        case localizedName = "localized_name"
    }
}

// User structure
struct User: Decodable {
    let username: String
}

//

func generateEvent_for_day(attraction_list: [String], geos_list: [String], restaurant_list: [String], daynumber: Int, attrac_id:[String], geos_id: [String], restaurant_id: [String]) -> Day{
    let target_attrc_id = attrac_id[daynumber]
    let target_geo_id = geos_id[daynumber]
    let target_restaurant_id = restaurant_id[daynumber]
    
    
    var attrc_img = ""
    var geo_img = ""
    var res_img = ""
    
    let semaphore100 = DispatchSemaphore(value: 0)
    DataManager.shared.fetchImage(from: target_attrc_id) {
        result in
        //print(result)
        attrc_img = result
        semaphore100.signal()
    }
    semaphore100.wait()
    
    let semaphore101 = DispatchSemaphore(value: 0)
    DataManager.shared.fetchImage(from: target_geo_id) {
        result in
        //print(result)
        geo_img = result
        semaphore101.signal()
    }
    semaphore101.wait()
    
    let semaphore102 = DispatchSemaphore(value: 0)
    DataManager.shared.fetchImage(from: target_restaurant_id) {
        result in
        //print(result)
        res_img = result
        semaphore102.signal()
    }
    semaphore102.wait()
    

    let Event1 = Event(id: UUID(), name: attraction_list[daynumber] , img: attrc_img, type: .attraction)
    let Event2 = Event(id: UUID(), name: geos_list[daynumber] ,  img: geo_img, type: .geo)
    let Event3 = Event(id: UUID(), name: restaurant_list[daynumber] , img: res_img,  type: .restaurant)
    let Dayplan = Day(id: UUID(), dayNumber: daynumber + 1, events: [Event1, Event2, Event3])
    
    return Dayplan
}



//func generate_itinerary(attrac: [String], geos: [String], restaurant: [String], daynumber: Int, location: String, attrac_id:[String], geos_id: [String], restaurant_id: [String]) -> Itinerary {
//    var dayplan: [Day] = []
//    for i in 0...daynumber {
//        dayplan.append(generateEvent_for_day(attraction_list: attrac, geos_list: geos, restaurant_list: restaurant, daynumber: i, attrac_id: attrac_id, geos_id: geos_id, restaurant_id: restaurant_id))
//    }
//    let Itinerary = Itinerary(id: UUID(), location: location, isCurrent: false, days:dayplan,  lastEditDate: Date())
//    return Itinerary
//}


func generate_itinerary(attrac: [String], geos: [String], restaurant: [String], daynumber: Int, location: String, attrac_id:[String], geos_id: [String], restaurant_id: [String]) -> Itinerary {
    
    let itinerary_place_id = geos_id[0]
    var dayplan: [Day] = []
    for i in 0...daynumber {
        dayplan.append(generateEvent_for_day(attraction_list: attrac, geos_list: geos, restaurant_list: restaurant, daynumber: i, attrac_id: attrac_id, geos_id: geos_id, restaurant_id: restaurant_id))
    }
    
    var itinerary_img = ""
    
    let semaphore100 = DispatchSemaphore(value: 0)
    DataManager.shared.fetchImage(from: itinerary_place_id) {
        result in
        //print(result)
        itinerary_img = result
        semaphore100.signal()
    }
    semaphore100.wait()
    
    let Itinerary = Itinerary(id: UUID(), location: location, img: itinerary_img, isCurrent: false, days:dayplan,  lastEditDate: Date())
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
    
    func fetchImage(from location_id: String, completion: @escaping (String) -> Void) {
        let locationURL = "https://api.content.tripadvisor.com/api/v1/location/\(location_id)/photos?key=547B30F2C5CF4458B82FAC44F069D0FA&language=en"
        
        guard let url = URL(string: locationURL) else {
            print("Error: Invalid URL")
            completion("Invalid URL")
            return
        }
        print(locationURL)

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion("Error: \(error.localizedDescription)")
                return
            }

            // Assuming you're checking the response status here
            // ...

            guard let data = data else {
                print("Error: No data to decode")
                completion("No data to decode")
                return
            }

            guard let answer = try? JSONDecoder().decode(Root.self, from: data) else {
                print("Error: Couldn't decode data into Answer (Image)")
                completion("Couldn't decode data")
                return
            }

            if answer.data.isEmpty {
                print(1)
                completion("No data found")
            } else {
                print(2)
                print(answer.data[0].images.original.url)
                completion(answer.data[0].images.original.url)
            }
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


func generateEventList (bestDestination: CityDestination, category: Int) -> ([String], [String]){
    let key = "547B30F2C5CF4458B82FAC44F069D0FA"
    let latitude = String(bestDestination.latitude)
    let longtitude = String(bestDestination.longitude)
    let latlong = latitude + "," + longtitude
    if category == 1{
        let attractionsurl =
            "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=attractions&language=en"
      print(attractionsurl)
        let semaphore1 = DispatchSemaphore(value: 0)
        
        var attractions: [String] = []
        var attractions_id: [String] = []
        // get the id list for all the attraction activities
        DataManager.shared.fetchAndStoreIDs(from: attractionsurl) { success in
            if success {
                let ids = DataManager.shared.getStoredIDs()
                attractions_id = ids
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
        return (attractions, attractions_id)
    }
    else if category == 2{
        let geosurl =      "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=geos&language=en"
        var geos: [String] = []
        var geos_id:[String] = []
        let semaphore2 = DispatchSemaphore(value: 0)
        DataManager.shared.fetchAndStoreIDs(from: geosurl) { success in
            if success {
                let ids = DataManager.shared.getStoredIDs()
                geos_id = ids
                // Now you have the IDs and can use them
                //print("Stored IDs: \(ids)")
                let names = DataManager.shared.getStoredNames()
                geos = names
                //print("Stored Names: \(names)")
            } else {
                print("Failed to fetch IDs (geos).")
            }
            semaphore2.signal()
        }
        semaphore2.wait() // Wait for the signal
        return (geos, geos_id)
    }
    else{
        let restauranturl = "https://api.content.tripadvisor.com/api/v1/location/nearby_search?latLong=\(latitude)%2C\(longtitude)&key=547B30F2C5CF4458B82FAC44F069D0FA&category=restaurants&language=en"
        var restaurants: [String] = []
        var restaurants_id: [String] = []
        let semaphore3 = DispatchSemaphore(value: 0)
        DataManager.shared.fetchAndStoreIDs(from: restauranturl) { success in
            if success {
                let ids = DataManager.shared.getStoredIDs()
                // Now you have the IDs and can use them
                //print("Stored IDs: \(ids)")
                let names = DataManager.shared.getStoredNames()
                restaurants = names
                restaurants_id = ids
                //print("Stored Names: \(names)")
            } else {
                print("Failed to fetch IDs (restaurants).")
            }
            semaphore3.signal()
        }
        semaphore3.wait()
        return (restaurants, restaurants_id)
    }
}



struct GeneratingItineraryView: View {
    @State private var itinerary: Itinerary? = nil
    var location: String
    var bestDestination: CityDestination
    @State private var isLoading = true
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(.colorGreenMedium), .clear]),
                startPoint: .top,
                endPoint: .bottom
            )
            
            VStack {
                if isLoading {
                    LoadingView()
                        .padding(.top, 30)
                } else {
                    let attractions = generateEventList(bestDestination: bestDestination, category: 1)
                    let geos = generateEventList(bestDestination: bestDestination, category: 2)
                    let restaurants = generateEventList(bestDestination: bestDestination, category: 3)
                    
                    let itinerary = generate_itinerary(attrac: attractions, geos: geos, restaurant: restaurants, daynumber: 3, location: location)
                    
                    let i = itinerary

                    Text("Generated Itinerary!")
                        .padding(.top, 30)
                        .font(.system(size: 40, weight: .bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    NavigationLink(destination: ItineraryDetailView(itinerary: itinerary, saved: false)) {
                        Text("Next")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("AccentColor"))
                            .cornerRadius(20)
                            .frame(width: 200, height: 50)
                    }
                }
            }
        }
        .onAppear {
            // Simulate a delay or some asynchronous task completion
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.isLoading = false
            }
        }
    }
}

struct LoadingView: View {
    @State private var rotation = 0.0

    var body: some View {
        VStack {
            Text("Generating Itinerary...")
                .font(.headline)
                .foregroundColor(.gray)

            Image(systemName: "arrow.2.circlepath.circle")
                .rotationEffect(.degrees(rotation))
                .foregroundColor(Color("AccentColor")) // Apply color to the symbols
                .onAppear() {
                    withAnimation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                        self.rotation = 360.0
                    }
                }
        }
        .padding()
    }
}
