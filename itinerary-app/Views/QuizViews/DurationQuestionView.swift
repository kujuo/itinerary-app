//
//  DurationQuestion.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/2/23.
//

//will need to revisit because need to put days in a varibale for the itinerary to know to make an itinerary for those amount of days
import SwiftUI

struct DurationQuestionView: View {
    var quiz: Quiz
    
    @State private var days = 0
    
    var body: some View {
            ZStack {
                Color(.colorGreenMedium)
                VStack {
                    Text("How long would you like your vacation to be?")
                        .font(.subheadline)
                        .padding(.top, 5) // Adjust top padding
                    Stepper("\(days) days", value: $days, in: 1...31)
                        .padding(.bottom, 10) // Adjust bottom padding
                  NavigationLink(destination: ContinentQuestionView(quiz: quiz)) {
                      Text("Next")
                          .font(.subheadline)
                          .fontWeight(.medium)
                          .foregroundColor(.white)
                          .frame(maxWidth: .infinity)
                          .padding()
                          .background(Color("AccentColor"))
                          .cornerRadius(20)
                          .frame(width: 200, height: 300)
                  }.simultaneousGesture(TapGesture().onEnded{
                    quiz.duration = days
                  })

                }
            }
    }
}




    
