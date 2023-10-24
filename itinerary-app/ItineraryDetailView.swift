//
//  ItineraryDetailView.swift
//  itinerary-app
//
//  Created by jhou on 10/24/23.
//

import Foundation
import SwiftUI
struct ItineraryDetailView: View {
  var itinerary: Itinerary
  var body: some View {
    VStack(alignment: .leading) {
      Text(itinerary.location + " events").font(.title)
      if (itinerary.days != nil) {
        ForEach(itinerary.days!) { day in
          Text("Day " + day.dayNumber.description)
          ForEach(day.events!) {
            event in
            HStack {
              Text(event.name)
              Text(event.description ?? "No description Available")
            }
          }
        }
      }
      Spacer()
    }.frame(maxWidth: .infinity, alignment: .topLeading)
  }
}
