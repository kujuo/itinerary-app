//
//  CityTypeView2.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/16/23.
//

import SwiftUI

struct CityTypeView2: View {
    
    var quiz: Quiz
    
    //variables for drop shadow
    @State private var shadowColor: Color = .customOrange
    @State private var shadowRadius: CGFloat = 8
    @State private var shadowX: CGFloat = 20
    @State private var shadowY: CGFloat = 0
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var selectedCity = CityType.island // Default selection
    
    private let images: [String] = ["dubai", "island", "nature", "big_city"]
    
    private let cityTypes: [CityType] = [.island, .metropolitanCity, .desert, .natureReserve]
    
    var body: some View {
        ZStack {
            // Gradient background covering the upper half of the screen
            LinearGradient(
                gradient: Gradient(colors: [Color(.colorGreenMedium), .clear]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                ZStack {
                    // Bigger rounded rectangle as a background with stroke
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color.colorGreenMedium)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(lineWidth: 0) // Adjust the thickness of the stroke
                                .foregroundColor(Color.customBlush) // Stroke color
                            //.shadow(color: .customBlush, radius: 5, x:  2, y: 2)
                        )
                        .frame(width: 320, height: 190)
                    // define the shadow using the state variables from earlier
                        .shadow(color: shadowColor, radius: shadowRadius, x: shadowX, y: shadowY)
                    
                        .onAppear() {
                            withAnimation(.linear(duration: 1.5)) {
                                shadowColor = .customOrange
                                shadowRadius = 4
                                shadowX =  -5
                                shadowY = 5
                            }
                        }
                    
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(Color.customLightTan.opacity(0.5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(lineWidth: 1) // Adjust the thickness of the border
                                .foregroundColor(Color.customOrange) // Border color
                                .shadow(color: .customOrange, radius: 3, x:  2, y: 2)
                        )
                        .frame(width: 280, height: 130) // Adjust size accordingly
                    
                    Spacer()
                    // Text with thick rounded border
                    Text("Select the type of city you would like to visit: ")
                        .font(.system(size: 20))
                    //.foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .fontWeight(.medium)
                        .padding()
                        .frame(width: 300, height: 150)
                    
                    Divider()
                        .background(Color.customOrange)
                        .frame(width: 400, height: 2)
                        .offset(y: 300) // Adjust the offset to position the divider
                    
                    Button {
                        updateQuizCityType(cityType: .desert)
                    } label: {
                        ZStack {
                            Image("dubai")
                            Text("desert")
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
                    
                    Button {
                        updateQuizCityType(cityType: .island)
                    } label: {
                        ZStack {
                            Image("island")
                            Text("island")
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
                    
                    Button {
                        updateQuizCityType(cityType: .natureReserve)
                    } label: {
                        ZStack {
                            Image("nature")
                            Text("Nature Reserve")
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
                    
                    Button {
                        updateQuizCityType(cityType: .metropolitanCity)
                    } label: {
                        ZStack {
                            Image("big_city")
                            Text("Metropolitan City")
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
                    
                    Button {
                        updateQuizCityType(cityType: .historical)
                    } label: {
                        ZStack {
                            Image("historical")
                            Text("Historical")
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
                    
                    Button {
                        updateQuizCityType(cityType: .modern)
                    } label: {
                        ZStack {
                            Image("modern")
                            Text("Modern")
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
                    
                    Button {
                        updateQuizCityType(cityType: .coastal)
                    } label: {
                        ZStack {
                            Image("coastal")
                            Text("Coastal")
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
                
                
                Spacer()
                
                VStack(spacing:40) {
                    HStack {
                        
                    }
                }
                .padding(.top, 60)
            }
        }
    }    
    private func updateQuizCityType(cityType: CityType) {
        quiz.cityType = cityType
    }
}
