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
        Text("Current Itinerary").font(.title2).fontWeight(.bold)
        if let current {
          ItineraryNavView(itinerary: current, isCurrent: true, saved: true)
        }
        Spacer(minLength: 20)
        Text("Past Itineraries").font(.title2).frame(alignment:.leading).fontWeight(.bold)
        ScrollView(.vertical) {
          ForEach(itineraries) { itinerary in
            ItineraryNavView(itinerary: itinerary, isCurrent: false, saved: true)
          }
        }.frame(alignment: .leading)
      }
    }
  }
}

#Preview {
    HistoryView(itineraryRepository: ItineraryRepository())
}
