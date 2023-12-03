//
//  EventDetailView.swift
//  itinerary-app
//
//  Created by jhou on 11/5/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct EventDetailView: View {
  var event: Event
  var itinerary: Itinerary
  @Binding var path: NavigationPath
//  var dayEvent: (Int, Int)
  var body: some View {
    var meow = event
//    let day = dayEvent.0
//    let eventNum = dayEvent.1
    VStack(alignment: .center) {
      Text(event.name).font(.title).fontWeight(.heavy)/*.frame(alignment: .leading)/*.padding(20)*/*/
      if let url = event.url {
        Link(destination: URL(string: url)!) {}
      }
      if let imgLink = event.img {
        AsyncImage(url: URL(string: imgLink)) { image in image.resizable() }
          placeholder: { Color.blue.opacity(0.7) }
          .frame(width: UIScreen.main.bounds.width, height: 250)
          .aspectRatio(contentMode: .fit).frame(maxWidth: .infinity)
      }
      VStack(alignment: .leading) {
        Text(timeTransform(time: event.timeStart) + "-" + timeTransform(time: event.timeEnd))
          .font(.title3).fontWeight(.bold).padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        Text(event.description ?? "")
      }.frame(maxWidth: 340, alignment: .center)/*.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))*/
      HStack {
        Button("Delete", role: .destructive) {
          let store = Firestore.firestore()
          let itineraryRef = store.collection("itineraries").document(itinerary.id.uuidString)
          var newItinerary: Itinerary = itinerary
          for i in 0..<(itinerary.days?.count)! {
            var day = itinerary.days![i]
            for j in 0..<(day.events?.count)! {
              var newEvent = day.events![j]
              if newEvent.id == event.id {
                newItinerary.days![i].events!.remove(at: j)
//                newItinerary.days![i].events![j].name="Testing12345"
                if newItinerary.days![i].events!.isEmpty {
                  newItinerary.days!.remove(at:i)
                }
                newItinerary.lastEditDate = Date()
//                newEvent.name = "Testing12345"
                do {
                  try itineraryRef.setData(from: newItinerary)
                } catch let error {
                  print("Error writing city to Firestore: \(error)")
                }
//                navStateManager.path = NavigationPath()
                path.removeLast()
              }
            }
          }

//          newItinerary.days![day].events![eventNum].name = "Test changes"
//          newItinerary.days![day].events!.remove(at: eventNum)
//          newItinerary.lastEditDate = Date()
////          print(newItinerary.days![day])
//          do {
//            try itineraryRef.setData(from: newItinerary)
//          } catch let error {
//            print("Error writing city to Firestore: \(error)")
//          }
        }
        NavigationLink(value: event) {
          Button("Edit") {
            let store = Firestore.firestore()
            let itineraryRef = store.collection("itineraries").document(itinerary.id.uuidString)
            var newItinerary: Itinerary = itinerary
            for i in 0..<(itinerary.days?.count)! {
              var day = itinerary.days![i]
              for j in 0..<(day.events?.count)! {
                var newEvent = day.events![j]
                if newEvent.id == event.id {
                }
              }
            }
          }
        }
      }
      Spacer()
    }
  }
    
}

