//
//  ItineraryRowView.swift
//  itinerary-app
//
//  Created by jhou on 10/24/23.
//

import Foundation
import Foundation
import SwiftUI

struct ItineraryRowView: View {
  var itinerary: Itinerary
  
  var body: some View {
    NavigationLink(
      destination: ItineraryDetailView(itinerary: itinerary),
      label: {
        VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
          Text(itinerary.location)
          Text(itinerary.lastEditDate.description)
        })
      })
  }
}
