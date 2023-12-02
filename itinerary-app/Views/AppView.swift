//
//  AppView.swift
//  itinerary-app
//
//  Created by jhou on 11/1/23.
//
import SwiftUI

class NavigationStateManager: ObservableObject {

    @Published var path = NavigationPath()
    
    func popToRoot() {
        path = NavigationPath()
    }
}

struct AppView: View {
  @ObservedObject var itineraryRepository = ItineraryRepository.itineraryRepository
  @ObservedObject var navStateManager = NavigationStateManager()
  @State private var selectedTab: Tab = .home
  @State private var resetNavigation = false
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
          }.onTapGesture {
            HistoryView().path = NavigationPath()
          }
      
        QuizBeginningView()
          .tabItem {
            Image(systemName: "plus.circle.fill")
            Text("Create Itinerary")
          }
      }.environmentObject(navStateManager)
      .onChange(of: selectedTab) { newTab in
        navStateManager.popToRoot()
        print("Changed Tabe")
      }
  }
}
enum Tab: String {
    case home
    case history
    case quiz
}
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
