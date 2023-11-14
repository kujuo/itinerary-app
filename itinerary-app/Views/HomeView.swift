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
  @ObservedObject var loc = LocationRepository.locationRepository
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
//          for des in cityDestinations {
//            let collectionRef = store.collection("cityDestinations")
//            do {
//              let newDocReference = try collectionRef.document(des.name).setData(from: des)
//  //            let newDocReference = try collectionRef.addDocument(from: itinerary)
//              print("Itinerary stored with new document reference: \(newDocReference)")
//            }
//            catch {
//              print(error)
//            }
//          }
////          let event1 = Event(id: UUID(), name: "Baguette Cafe", type: EventType.meal, timeStart: "0700", timeEnd: "1030", url: "https://maps.app.goo.gl/eM3YziUNKzWNmwnX8")
////          let itinerary = Itinerary(id: UUID(), location: "Test Saving Itinerary", img: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Tour_Eiffel_Wikimedia_Commons_%28cropped%29.jpg/800px-Tour_Eiffel_Wikimedia_Commons_%28cropped%29.jpg", isCurrent: false, days: [day], lastEditDate: Date())
////
//        })
    }
}

#Preview {
    HomeView()
}

