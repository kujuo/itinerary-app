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
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding().onAppear(perform: {
          let store = Firestore.firestore()
          let event1 = Event(id: UUID(), name: "testing", type: EventType.meal, timeStart: "1200", timeEnd: "1400")
          let day = Day(id: UUID(), events: [event1])
          let itinerary = Itinerary(id: UUID(), location: "paris", img: "peepee", isCurrent: true, days: [day])
          let collectionRef = store.collection("itineraries")
          do {
            let newDocReference = try collectionRef.addDocument(from: itinerary)
            print("Book stored with new document reference: \(newDocReference)")
          }
          catch {
            print(error)
          }

        })
    }
}

#Preview {
    ContentView()
}

