//
//  QuizBeginningView.swift
//  itinerary-app
//
//  Created by Mitun Adenuga on 11/2/23.
//



// would I have a navigation link or just a button that moves to next page
//NavigationLink(
   //destination: DurationQuestionView(quiz: quiz)) {

import SwiftUI

struct QuizBeginningView: View {
  //@ObservedObject var quiz: Quiz
    var body: some View {
        VStack {
            Text("Welcome to the Location Finder")
                .font(.largeTitle)
            CardView()
        }
    }
}

    

