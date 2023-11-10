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
    @State private var selectedCity = Quiz.City.island // Default selection
    
    private let images: [String] = ["dubai", "island", "nature", "big_city"]
    
    private let cityTypes: [Quiz.City] = [.island, .metropolitanCity, .desert, .natureReserve]
    
    var body: some View {
            VStack {
                Text("Select the type of city you'd like to visit:")
                    .padding(.bottom, 10)
                Picker("City Type", selection: $selectedCity) {
                    ForEach(Quiz.City.allCases, id: \.self) { cityType in
                        Text(cityType.rawValue).tag(cityType)
                    }
                }
                .pickerStyle(.wheel) // You can use other styles as well
                
                Button {
                    quiz.cityType = selectedCity
                } label: {
                    NavigationLink(
                        destination: GivenLocationView(quiz: quiz)
                    ) {
                        Text("Next")
                    }
                }
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



/*VStack {
 Color(.colorGreenMedium)
 VStack {
     Text("Click the picture that represents the type of city you would like to go to:")
         .padding(.bottom, 10)
 }
}*/
