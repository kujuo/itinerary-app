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
    VStack {
      Text(itinerary.location)
      List {
        if (itinerary.days != nil) {
          ForEach(itinerary.days!) { day in
            ForEach(day.events!) {
              event in
              HStack {
                Text(event.description ?? "")
                Text(event.name)
              }
            }
          }
        }
      }
    }
  }
}
