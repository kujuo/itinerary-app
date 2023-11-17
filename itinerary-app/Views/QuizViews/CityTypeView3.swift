//
//  CityTypeView3.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/16/23.
//

/*import SwiftUI

struct CityTypeView3: View {
    
    var quiz: Quiz
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var selectedCity = CityType.island // Default selection
    
    private let images: [String] = ["dubai", "island", "nature", "big_city"]
    
    private let cityTypes: [CityType] = [.island, .metropolitanCity, .desert, .natureReserve]
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    // Gradient background covering the upper half of the screen
                    LinearGradient(
                        gradient: Gradient(colors: [Color(.colorGreenMedium), .clear]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .edgesIgnoringSafeArea(.all)
                    
                    // loop for carousel
                    ForEach(0..<cityTypes.count, id: \.self) { index in Image(images[index])
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                            .frame(width: 280, height: 440)
                            .cornerRadius(25)
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.2: 0.8)
                            .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y:0)
                        Spacer()
                    }
                }
                .gesture(
                DragGesture()
                    .onEnded({ value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                currentIndex = min(images.count - 1, currentIndex + 1)
                            }
                        }
                    })
                )
            }
            // put header here

            
        }
    }
} */

import SwiftUI

struct CityTypeView3: View {
    var quiz: Quiz
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0
    private let images: [String] = ["dubai", "island", "nature", "big_city"]
    private let cityTypes: [CityType] = [.desert, .natureReserve, .modern, .historical, .coastal]

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color(.colorGreenMedium), .clear]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .edgesIgnoringSafeArea(.all)
                    
                    ForEach(0..<cityTypes.count, id: \.self) { index in
                        NavigationLink(
                            destination: GivenLocationView(quiz: quiz, cityType: cityTypes[index]),
                            label: {
                                CityTypeImageView(cityType: cityTypes[index], quiz: quiz, index: index, currentIndex: $currentIndex, dragOffset: $dragOffset)
                                    .navigationBarHidden(true)
                            }
                        )
                        Spacer()
                    }
                }
                .gesture(
                    DragGesture()
                        .onEnded({ value in
                            let threshold: CGFloat = 50
                            if value.translation.width > threshold {
                                withAnimation {
                                    currentIndex = max(0, currentIndex - 1)
                                }
                            } else if value.translation.width < -threshold {
                                withAnimation {
                                    currentIndex = min(images.count - 1, currentIndex + 1)
                                }
                            }
                        })
                )
            }
        }
    }
}

struct CityTypeImageView: View {
    let cityType: CityType
    let quiz: Quiz
    let index: Int
    @Binding var currentIndex: Int
    @Binding var dragOffset: CGFloat

    var body: some View {
        Image(cityType.imageName)
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .frame(width: 280, height: 440)
            .cornerRadius(25)
            .opacity(currentIndex == index ? 1.0 : 0.5)
            .scaleEffect(currentIndex == index ? 1.2 : 0.8)
            .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
            .onTapGesture {
                currentIndex = index
                dragOffset = 0
                updateQuizCityType(cityType: cityType)
            }
    }
    
    private func updateQuizCityType(cityType: CityType) {
        quiz.cityType = cityType
        quiz.cityTypeUpdate(cityType: cityType, points: 1)
    }
}
