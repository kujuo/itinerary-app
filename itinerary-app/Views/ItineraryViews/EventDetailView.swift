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
  @State var event: Event
  @State var itinerary: Itinerary
  @State var editing: Bool = false
  //  var dayEvent: (Int, Int)
  var body: some View {
    if !editing {
        //    let day = dayEvent.0
        //    let eventNum = dayEvent.1
        VStack(alignment: .center) {
          HStack {
            Text(event.name).font(.title).fontWeight(.heavy)/*.frame(alignment: .leading)/*.padding(20)*/*/
            if let url = event.url {
              if let convertedUrl = URL(string:url) {
                Link(destination: convertedUrl) { Image(systemName: "link") }
              }
            }
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
            Button("Edit") { editing = true }
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
                      print("worked")
                    } catch let error {
                      print("Error writing city to Firestore: \(error)")
                    }
                    //                navStateManager.path = NavigationPath()
//                    path.removeLast()
//                    path = NavigationPath()
                  }
                }
              }
            }
          }
          Spacer()
          
        }
        
        
        
      }
      else {
        EditItineraryEvent(event: $event, itinerary: itinerary, editing: $editing)
      }
      
    }
  }
  

extension EventType {
  static var allCases: [EventType] {
    return [.restaurant, .geo, .attraction, .travel]
      }
}
struct EditItineraryEvent: View {
  @Binding var event: Event
  @State var itinerary: Itinerary
  @Binding var editing: Bool
  var body: some View {
    let origEvent = event
    VStack {
      Form {
        Section(header: Text("Event Details")) {
          TextField("Event name", text: $event.name ).fontWeight(.heavy).multilineTextAlignment(.leading)
          TextField("Description", text: $event.description.toUnwrapped(defaultValue: ""))
        }

        Section(header: Text("Other Information")) {
          Picker("Event type", selection: $event.type) {
            ForEach(EventType.allCases, id: \.self) { option in
              Text(option.rawValue.capitalized)
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          TextField("Link", text: $event.url.toUnwrapped(defaultValue: "")).autocapitalization(.none)
          TextField("Image Link", text: $event.img.toUnwrapped(defaultValue: "")).autocapitalization(.none)
        }
        
        HStack {
          Button("Revert to original") {
            event.name = origEvent.name
            event.description = origEvent.description
            event.type = origEvent.type
            event.url = origEvent.url
            event.img = origEvent.img
            editing = false
            print("discard")
          }
          Spacer()
          Button("Save") {
            editing = false
            var saveEvent = event
            saveEvent.name = event.name
            saveEvent.description = event.description
            saveEvent.type = event.type
            if (event.url == "") {
              saveEvent.url = nil
            } else { saveEvent.url = event.url }
            if (event.img == "") {
              saveEvent.img = nil
            } else { saveEvent.img = event.img }
            let store = Firestore.firestore()
            let itineraryRef = store.collection("itineraries").document(itinerary.id.uuidString)
            var newItinerary: Itinerary = itinerary
            for i in 0..<(itinerary.days?.count)! {
              var day = itinerary.days![i]
              for j in 0..<(day.events?.count)! {
                var newEvent = day.events![j]
                if newEvent.id == event.id {
                  newItinerary.days![i].events![j] = saveEvent
                  newItinerary.lastEditDate = Date()
                  print(newItinerary)
                  do {
                    try itineraryRef.setData(from: newItinerary)
                  } catch let error {
                    print("Error writing city to Firestore: \(error)")
                  }
                }
              }
            }
          }
        }.buttonStyle(BorderlessButtonStyle())
      }
    }

//    VStack {
////      NavigationLink(destination: EventNavView(event: event, itinerary: itinerary)) {
////        Text("dsfklj")
////      }
////      TextField("Event name", text: $event.name ).fontWeight(.heavy).multilineTextAlignment(.leading)
////      TextField("Name", text: $event.name )
////      TextField("Description", text: $event.description.toUnwrapped(defaultValue: ""))
////      TextField("Name", text: $event.name )
//
//
//    }.frame(maxWidth: 340)
  }
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
