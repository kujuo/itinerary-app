//
//  AppView.swift
//  itinerary-app
//
//  Created by jhou on 11/1/23.
//

import SwiftUI

struct AppView: View {
  @ObservedObject var itineraryRepository = ItineraryRepository.itineraryRepository
  var body: some View {
    
    TabView {
      HomeView()
      .tabItem {
          Image(systemName: "globe.europe.africa.fill")
          Text("Home")
      }
      
      HistoryView(/*itineraryRepository: itineraryRepository*/)
      .tabItem {
          Image(systemName: "text.book.closed.fill")
          Text("History")
      }
      
        QuizBeginningView()
      .tabItem {
          Image(systemName: "plus.circle.fill")
          Text("Create Itinerary")
      }
    }
  }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

