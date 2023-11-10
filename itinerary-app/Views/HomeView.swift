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
  @ObservedObject var itineraryRepository = ItineraryRepository.itineraryRepository
  var body: some View {
    let current = itineraryRepository.currentItinerary
    
    NavigationStack {
      Text("Welcome!").font(.title).fontWeight(.heavy)
      Spacer()
      VStack(alignment: .leading) {
        Text("Current Itinerary").font(.title2).fontWeight(.bold)
        if let current {
          ItineraryNavView(itinerary: current, isCurrent: true, saved: true/*, itineraryRepository: self.itineraryRepository*/)
        }
        else {
          ZStack {
            // Gradient on top of the image
            Rectangle()
                .fill(lightBlueColor)
                .frame(width: 340, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            // Text within the button
            HStack {
              Text("Set an itinerary as your current one!").frame(alignment: .leading)
                .fontWeight(.bold).foregroundColor(Color.white)
                .font(.title3)
            }.padding(10)
              Spacer()
          }.frame(maxWidth: 340, maxHeight: 200, alignment: .leading)
        }
      }
      Spacer()
    }
//        .onAppear(perform: {
//          let store = Firestore.firestore()
//          let event1 = Event(id: UUID(), name: "Baguette Cafe", type: EventType.meal, timeStart: "0700", timeEnd: "1030", url: "https://maps.app.goo.gl/eM3YziUNKzWNmwnX8")
//          let event2 = Event(id: UUID(), name: "Walk", type: EventType.travel, timeStart: "1030", timeEnd: "1230", url: "https://www.google.com/maps/dir/Pamela's+Diner,+Forbes+Avenue,+Pittsburgh,+PA/Carnegie+Museum+of+Natural+History,+Forbes+Avenue,+Pittsburgh,+PA/@40.4427904,-79.9593845,15.77z/data=!4m13!4m12!1m5!1m1!1s0x8834f229e57e54fb:0x85711e3bfcf4be29!2m2!1d-79.9575695!2d40.4412653!1m5!1m1!1s0x8834f3c2df9e12c1:0x229123cb51fbc6a8!2m2!1d-79.949974!2d40.4433215?entry=ttu")
//          let event3 = Event(id: UUID(), name: "Eiffel Tower", description: "The Eiffel Tower is a wrought-iron lattice tower on the Champ de Mars in Paris, France. It is named after the engineer Gustave Eiffel, whose company designed and built the tower from 1887 to 1889. Locally nicknamed \"La dame de fer\", it was constructed as the centerpiece of the 1889 World's Fair.",
//                             type: EventType.attraction, timeStart: "1230", timeEnd: "1700")
//          let event4 = Event(id: UUID(), name: "Walk", type: EventType.travel, timeStart: "1700", timeEnd: "1730", url: "https://www.google.com/maps/dir/Pamela's+Diner,+Forbes+Avenue,+Pittsburgh,+PA/Carnegie+Museum+of+Natural+History,+Forbes+Avenue,+Pittsburgh,+PA/@40.4427904,-79.9593845,15.77z/data=!4m13!4m12!1m5!1m1!1s0x8834f229e57e54fb:0x85711e3bfcf4be29!2m2!1d-79.9575695!2d40.4412653!1m5!1m1!1s0x8834f3c2df9e12c1:0x229123cb51fbc6a8!2m2!1d-79.949974!2d40.4433215?entry=ttu")
//          let event5 = Event(id: UUID(), name: "Baguette Dinner", type: EventType.meal, timeStart: "1730", timeEnd: "2000", url: "https://www.google.com/maps/dir/Pamela's+Diner,+Forbes+Avenue,+Pittsburgh,+PA/Carnegie+Museum+of+Natural+History,+Forbes+Avenue,+Pittsburgh,+PA/@40.4427904,-79.9593845,15.77z/data=!4m13!4m12!1m5!1m1!1s0x8834f229e57e54fb:0x85711e3bfcf4be29!2m2!1d-79.9575695!2d40.4412653!1m5!1m1!1s0x8834f3c2df9e12c1:0x229123cb51fbc6a8!2m2!1d-79.949974!2d40.4433215?entry=ttu")
//
//          let day = Day(id: UUID(), dayNumber: 1, events: [event1, event2, event3, event4, event5])
//          let event6 = Event(id: UUID(), name: "Baguette 2", type: EventType.meal, timeStart: "0800", timeEnd: "1000", url: "https://maps.app.goo.gl/eM3YziUNKzWNmwnX8")
//          let event7 = Event(id: UUID(), name: "Bus", type: EventType.travel, timeStart: "1000", timeEnd: "1030", url: "https://www.google.com/maps/dir/Pamela's+Diner,+Forbes+Avenue,+Pittsburgh,+PA/Carnegie+Museum+of+Natural+History,+Forbes+Avenue,+Pittsburgh,+PA/@40.4427904,-79.9593845,15.77z/data=!4m13!4m12!1m5!1m1!1s0x8834f229e57e54fb:0x85711e3bfcf4be29!2m2!1d-79.9575695!2d40.4412653!1m5!1m1!1s0x8834f3c2df9e12c1:0x229123cb51fbc6a8!2m2!1d-79.949974!2d40.4433215?entry=ttu")
//          let event8 = Event(id: UUID(), name: "Eiffel Tower 2", description: "The Carnegie Museum of Natural History (abbreviated as CMNH) is a natural history museum in the Oakland neighborhood of Pittsburgh, Pennsylvania. It was founded by Pittsburgh-based industrialist Andrew Carnegie in 1896. Housing some 22 million specimens, the museum features one of the finest paleontological collections in the world.", type: EventType.attraction, timeStart: "1030", timeEnd: "1400")
//          let event9 = Event(id: UUID(), name: "Baguette 3", type: EventType.meal, timeStart: "1400", timeEnd: "1500", url: "https://maps.app.goo.gl/eM3YziUNKzWNmwnX8")
//          let event10 = Event(id: UUID(), name: "Bus", type: EventType.travel, timeStart: "1500", timeEnd: "130", url: "https://www.google.com/maps/dir/Pamela's+Diner,+Forbes+Avenue,+Pittsburgh,+PA/Carnegie+Museum+of+Natural+History,+Forbes+Avenue,+Pittsburgh,+PA/@40.4427904,-79.9593845,15.77z/data=!4m13!4m12!1m5!1m1!1s0x8834f229e57e54fb:0x85711e3bfcf4be29!2m2!1d-79.9575695!2d40.4412653!1m5!1m1!1s0x8834f3c2df9e12c1:0x229123cb51fbc6a8!2m2!1d-79.949974!2d40.4433215?entry=ttu")
//          let event11 = Event(id: UUID(), name: "Eiffel Tower 3", description: "The Carnegie Museum of Natural History (abbreviated as CMNH) is a natural history museum in the Oakland neighborhood of Pittsburgh, Pennsylvania. It was founded by Pittsburgh-based industrialist Andrew Carnegie in 1896. Housing some 22 million specimens, the museum features one of the finest paleontological collections in the world.", type: EventType.attraction, timeStart: "1030", timeEnd: "1400")
//
////          let day2 = Day(id: UUID(), dayNumber: 2, events: [event6, event7, event8, event9, event10])
//
//          let itinerary = Itinerary(id: UUID(), location: "Test Saving Itinerary", img: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Tour_Eiffel_Wikimedia_Commons_%28cropped%29.jpg/800px-Tour_Eiffel_Wikimedia_Commons_%28cropped%29.jpg", isCurrent: false, days: [day], lastEditDate: Date())
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

