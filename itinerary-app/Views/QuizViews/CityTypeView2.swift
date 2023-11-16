//
//  CityTypeView2.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/16/23.
//

import SwiftUI

struct CityTypeView2: View {

    var quiz: Quiz

    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0

    private let cityTypes: [CityType] = [.desert, .island, .natureReserve, .metropolitanCity, .historical, .modern, .coastal]

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(.colorGreenMedium), .clear]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                ZStack {
                    /* RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color.colorGreenMedium)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(lineWidth: 0)
                                .foregroundColor(Color.customBlush)
                        )
                        .frame(width: 320, height: 190)
                        .shadow(color: .customOrange, radius: 8, x: 20, y: 0)

                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color.customLightTan.opacity(0.5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(lineWidth: 1)
                                .foregroundColor(Color.customOrange)
                                .shadow(color: .customOrange, radius: 3, x: 2, y: 2)
                        )
                        .frame(width: 280, height: 130)

                    Spacer()

                    Text("Select the type of city you would like to visit: ")
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .fontWeight(.medium)
                        .padding()
                        .frame(width: 300, height: 150)

                    Divider()
                        .background(Color.customOrange)
                        .frame(width: 400, height: 2)
                        .offset(y: 300) */

                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(0..<cityTypes.count, id: \.self) { index in
                                CityTypeButton(cityType: cityTypes[index], currentIndex: $currentIndex, buttonIndex: index, updateQuizCityType: updateQuizCityType)
                            }
                        }
                        .padding()
                    }
                }

                Spacer()

                VStack(spacing: 40) {
                    HStack {}
                }
                .padding(.top, 60)
            }
        }
    }

    private func updateQuizCityType(cityType: CityType) {
        quiz.cityType = cityType
    }
}

struct CityTypeButton: View {
    let cityType: CityType
    @Binding var currentIndex: Int
    let buttonIndex: Int
    let updateQuizCityType: (CityType) -> Void

    var body: some View {
        Button {
            currentIndex = buttonIndex
            updateQuizCityType(cityType)
        } label: {
            VStack {
                Image(cityType.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 300)
                    .opacity(currentIndex == buttonIndex ? 1.0 : 0.5)
                Text(cityType.rawValue)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("AccentColor"))
                    .cornerRadius(20)
            }
        }
    }
}
