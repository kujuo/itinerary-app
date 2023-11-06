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
    NavigationStack {
//      Text("Hello, SwiftUI!").navigationTitle("dfslkjsldfkj")
//          .navigationBarTitleDisplayMode(.inline)
//          .toolbar { // <2>
//              ToolbarItem(placement: .principal) { // <3>
//                  VStack {
//                      Text("Title").font(.headline)
//                      Text("Subtitle").font(.subheadline)
//                  }
//              }
//          }
//      ItineraryListView()
    }.navigationTitle("Characters")
//        .padding()
//        .onAppear(perform: {
//          let store = Firestore.firestore()
//          let event1 = Event(id: UUID(), name: "Pamela's Dinner", type: EventType.meal, timeStart: "0800", timeEnd: "1000", url: "https://maps.app.goo.gl/eM3YziUNKzWNmwnX8")
//          let event2 = Event(id: UUID(), name: "Bus", type: EventType.travel, timeStart: "1000", timeEnd: "1030", url: "https://www.google.com/maps/dir/Pamela's+Diner,+Forbes+Avenue,+Pittsburgh,+PA/Carnegie+Museum+of+Natural+History,+Forbes+Avenue,+Pittsburgh,+PA/@40.4427904,-79.9593845,15.77z/data=!4m13!4m12!1m5!1m1!1s0x8834f229e57e54fb:0x85711e3bfcf4be29!2m2!1d-79.9575695!2d40.4412653!1m5!1m1!1s0x8834f3c2df9e12c1:0x229123cb51fbc6a8!2m2!1d-79.949974!2d40.4433215?entry=ttu")
//          let event3 = Event(id: UUID(), name: "Carnegie Museum of Natural History", description: "The Carnegie Museum of Natural History (abbreviated as CMNH) is a natural history museum in the Oakland neighborhood of Pittsburgh, Pennsylvania. It was founded by Pittsburgh-based industrialist Andrew Carnegie in 1896. Housing some 22 million specimens, the museum features one of the finest paleontological collections in the world.", type: EventType.attraction, timeStart: "1030", timeEnd: "1400")
//          let day = Day(id: UUID(), dayNumber: 1, events: [event1, event2, event3])
//          let event4 = Event(id: UUID(), name: "Pamela's Dinner", type: EventType.meal, timeStart: "0800", timeEnd: "1000", url: "https://maps.app.goo.gl/eM3YziUNKzWNmwnX8")
//          let event5 = Event(id: UUID(), name: "Bus", type: EventType.travel, timeStart: "1000", timeEnd: "1030", url: "https://www.google.com/maps/dir/Pamela's+Diner,+Forbes+Avenue,+Pittsburgh,+PA/Carnegie+Museum+of+Natural+History,+Forbes+Avenue,+Pittsburgh,+PA/@40.4427904,-79.9593845,15.77z/data=!4m13!4m12!1m5!1m1!1s0x8834f229e57e54fb:0x85711e3bfcf4be29!2m2!1d-79.9575695!2d40.4412653!1m5!1m1!1s0x8834f3c2df9e12c1:0x229123cb51fbc6a8!2m2!1d-79.949974!2d40.4433215?entry=ttu")
//          let event6 = Event(id: UUID(), name: "Carnegie Museum of Natural History", description: "The Carnegie Museum of Natural History (abbreviated as CMNH) is a natural history museum in the Oakland neighborhood of Pittsburgh, Pennsylvania. It was founded by Pittsburgh-based industrialist Andrew Carnegie in 1896. Housing some 22 million specimens, the museum features one of the finest paleontological collections in the world.", type: EventType.attraction, timeStart: "1030", timeEnd: "1400")
//          let day2 = Day(id: UUID(), dayNumber: 2, events: [event4, event5, event6])
//
//          let itinerary = Itinerary(id: UUID(), location: "Pittsburgh", img: "imglink.com", isCurrent: true, days: [day, day2], lastEditDate: Date())
//          let collectionRef = store.collection("itineraries")
//          do {
//            let newDocReference = try collectionRef.document(itinerary.id.uuidString).setData(from: itinerary)
////            let newDocReference = try collectionRef.addDocument(from: itinerary)
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

