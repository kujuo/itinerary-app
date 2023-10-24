//
//  ItineraryListView.swift
//  itinerary-app
//
//  Created by jhou on 10/23/23.
//

import Foundation
import SwiftUI

struct ItineraryListView: View {
  @ObservedObject var itineraryRepository = ItineraryRepository()
  
  var body: some View {
    
    let itineraries = itineraryRepository.itineraries.sorted()
    Text("asklfjsdlkfjlskdfjd")
    NavigationView {
      List {
        ForEach(itineraries) { itinerary in
          HStack (alignment: .bottom, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            Text(itinerary.location)
            Spacer()
            Text(itinerary.lastEditDate.description)
          })
        }
      }
    }
  }
}
