//
//  GeneratingItineraryView.swift
//  itinerary-app
//
//  Created by jhou on 11/9/23.
//

import SwiftUI

struct GeneratingItineraryView: View {
  @State private var itinerary: Itinerary? = nil
  var location: String
    var body: some View {
      VStack {
        Text(location)
        if let i = itinerary {
          Text(itinerary?.location ?? "NO ITINERARY")
        }
      }
    }
}
