//
//  HistoryView.swift
//  itinerary-app
//
//  Created by jhou on 11/1/23.
//

import SwiftUI

struct HistoryView: View {
  @ObservedObject var itineraryRepository: ItineraryRepository
  var body: some View {
    let itineraries = itineraryRepository.itineraries.sorted()
    let current = itineraryRepository.currentItinerary
    NavigationStack {
      VStack(alignment: .leading) {
        Text("Current Itinerary").font(.title)
        if let current {
          ItineraryNavView(itinerary: current, sizeHeight: 200, isCurrent: true)
        }
//        ItineraryNavView(itinerary: current, sizeHeight: 200, isCurrent: false)
        Text("Past Itineraries").font(.title).frame(alignment:.leading)
        ScrollView(.vertical) {
          ForEach(itineraries) { itinerary in
            ItineraryNavView(itinerary: itinerary, sizeHeight: 100, isCurrent: false)
          }
          ForEach(itineraries) { itinerary in
            ItineraryNavView(itinerary: itinerary, sizeHeight: 100, isCurrent: false)
          }
          ForEach(itineraries) { itinerary in
            ItineraryNavView(itinerary: itinerary, sizeHeight: 100, isCurrent: false)
          }
          ForEach(itineraries) { itinerary in
            ItineraryNavView(itinerary: itinerary, sizeHeight: 100, isCurrent: false)
          }
          ForEach(itineraries) { itinerary in
            ItineraryNavView(itinerary: itinerary, sizeHeight: 100, isCurrent: false)
          }
          ForEach(itineraries) { itinerary in
            ItineraryNavView(itinerary: itinerary, sizeHeight: 100, isCurrent: false)
          }
        }.frame(alignment: .leading)
      }
    }
  }
}

#Preview {
    HistoryView(itineraryRepository: ItineraryRepository())
}
