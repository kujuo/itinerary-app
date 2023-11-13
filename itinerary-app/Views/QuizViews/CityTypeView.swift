//
//  CityTypeView2.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/9/23.
//


import SwiftUI

struct CityTypeView: View {
    
    var quiz: Quiz
  
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var selectedCity = CityType.island // Default selection
    
    private let images: [String] = ["dubai", "island", "nature", "big_city"]
    
    private let cityTypes: [CityType] = [.island, .metropolitanCity, .desert, .natureReserve]
    
    var body: some View {
            VStack {
//              Text(quiz.continent?.rawValue ?? "wrong").font(.title).bold()
                Text("Select the type of city you'd like to visit:")
                    .padding(.bottom, 10)
                Picker("City Type", selection: $selectedCity) {
                    ForEach(CityType.allCases, id: \.self) { cityType in
                        Text(cityType.rawValue).tag(cityType)
                    }
                }
                .pickerStyle(.wheel) // You can use other styles as well
                
              
              NavigationLink(destination: GivenLocationView(quiz: quiz)) {
                  Text("Next")
                  
              }.simultaneousGesture(TapGesture().onEnded{
                quiz.cityType = selectedCity
                quiz.cityTypeUpdate(cityType: selectedCity, points: 1)
              })
              
//              Optional([itinerary_app.CityDestination(name: "London", latitude: 51.5074, longitude: -0.1278, weather: "cold", cityType: ["modern", "historical"], continent: "Europe"): 1, itinerary_app.CityDestination(name: "Rio de Janeiro", latitude: -22.9068, longitude: -43.1729, weather: "hot", cityType: ["coastal"], continent: "South America"): 1, itinerary_app.CityDestination(name: "Cape Town", latitude: -33.9249, longitude: 18.4241, weather: "warm", cityType: ["coastal", "historical"], continent: "Africa"): 2, itinerary_app.CityDestination(name: "Paris", latitude: 48.8566, longitude: 2.3522, weather: "warm", cityType: ["modern", "historical"], continent: "Europe"): 1, itinerary_app.CityDestination(name: "Moscow", latitude: 55.7558, longitude: 37.6173, weather: "cold", cityType: ["modern", "historical"], continent: "Europe"): 1, itinerary_app.CityDestination(name: "Cairo", latitude: 30.0444, longitude: 31.2357, weather: "hot", cityType: ["historical"], continent: "Africa"): 3, itinerary_app.CityDestination(name: "Sydney", latitude: -33.8688, longitude: 151.2093, weather: "warm", cityType: ["modern", "coastal"], continent: "Australia"): 0, itinerary_app.CityDestination(name: "Tokyo", latitude: 35.6895, longitude: 139.6917, weather: "warm", cityType: ["modern", "coastal"], continent: "Asia"): 0, itinerary_app.CityDestination(name: "Vancouver", latitude: 49.2827, longitude: -123.1207, weather: "cold", cityType: ["modern", "coastal"], continent: "North America"): 0, itinerary_app.CityDestination(name: "New York", latitude: 40.7128, longitude: -74.006, weather: "warm", cityType: ["modern", "coastal"], continent: "North America"): 0])


            }
            NavigationStack {
                VStack {
                    ZStack {
                        ForEach(0..<images.count, id: \.self) { index in
                            Image(images[index])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 500)
                                .cornerRadius(25)
                                .opacity(currentIndex == index ? 1.0 : 0.5)
                                .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                                .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
                            //quiz.cityType = cityTypes[index]
                        }
                    }
                    
                }
                
                
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                                quiz.cityType = cityTypes[currentIndex]
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                currentIndex = min(images.count - 1, currentIndex + 1)
                                quiz.cityType = cityTypes[currentIndex]
                            }
                        }
                    }
            )
        }
    }




