//
//  ContentView.swift
//  itinerary-app
//
//  Created by jhou on 10/16/23.
//

import SwiftUI
import Combine
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
struct HomeView: View {
  
    var body: some View {
        VStack {
          ItineraryListView()
        }
//        .padding()
//        .onAppear(perform: {
//          let store = Firestore.firestore()
//          let event1 = Event(id: UUID(), name: "eat a lot of food", type: EventType.meal, timeStart: "1200", timeEnd: "1400")
////          let event2 = Event(id: UUID(), name: "go to a place", type: EventType.meal, timeStart: "1400", timeEnd: "1600")
//          let day = Day(id: UUID(), events: [event1])
//          let itinerary = Itinerary(id: UUID(), location: "new york", img: "imglink.com", isCurrent: true, days: [day], lastEditDate: Date())
//          let collectionRef = store.collection("itineraries")
//          do {
//            let newDocReference = try collectionRef.addDocument(from: itinerary)
//            print("Itinerary stored with new document reference: \(newDocReference)")
//          }
//          catch {
//            print(error)
//          }
//
//        })
    }
}

#Preview {
    HomeView()
}

