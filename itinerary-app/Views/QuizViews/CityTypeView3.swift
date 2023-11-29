//
//  CityTypeView3.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/16/23.
//

import SwiftUI

struct CityTypeView3: View {
    var quiz: Quiz
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0
    private let images: [String] = ["dubai", "island", "nature", "big_city", "history"]
    private let cityTypes: [CityType] = [.desert, .natureReserve, .modern, .historical, .coastal]

    var body: some View {
        VStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(.colorGreenMedium), .clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 300) // Adjust the height as needed

                ForEach(0..<cityTypes.count, id: \.self) { index in
                    Image(cityTypes[index].imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 250)
                        .frame(maxHeight: 250)
                        .cornerRadius(25)
                        .opacity(currentIndex == index ? 1.0 : 0.5)
                        .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                        .offset(x: CGFloat(index - currentIndex) * 250 + dragOffset, y: 0)
                        .onTapGesture {
                            currentIndex = index
                            dragOffset = 0
                        }
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

            Divider()
                .background(Color.customOrange)
                .frame(width: 400, height: 2)
                .offset(y: 100) // Adjust the offset to position the divider

            NavigationLink(destination: GivenLocationView(quiz: quiz)) {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("AccentColor"))
                    .cornerRadius(20)
                    .frame(width: 200, height: 300)
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
    @State private var isSelected: Bool = false
    private let cityTypes: [CityType] = [.desert, .natureReserve, .modern, .historical, .coastal]


    var body: some View {
        ZStack {
            Image(cityType.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 250)
                .cornerRadius(25)
                .opacity(isSelected ? 1.0 : 0.5)
                .scaleEffect(isSelected ? 1.2 : 0.8)
                .offset(x: CGFloat(index - currentIndex) * 250 + dragOffset, y: 0)

            if isSelected {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.black, lineWidth: 5)
                    .frame(width: 210, height: 260) // Adjust the frame to accommodate the border
                    .offset(x: CGFloat(index - currentIndex) * 250 + dragOffset, y: 0)
            }
        }
        .onTapGesture {
            if isSelected {
                isSelected = false
                currentIndex = -1
            } else {
                if currentIndex != -1 {
                    if let previouslySelectedIndex = (0..<cityTypes.count).first(where: { cityTypes[$0] == quiz.cityType }) {
                        currentIndex = previouslySelectedIndex
                    }
                }
                isSelected = true
                currentIndex = index
                dragOffset = 0
                updateQuizCityType(cityType: cityType)
            }
        }
    }

    public func updateQuizCityType(cityType: CityType) {
        quiz.cityType = cityType
        quiz.cityTypeUpdate(cityType: cityType, points: 1)
    }
}
