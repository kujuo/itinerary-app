//
//  EventDetailView.swift
//  itinerary-app
//
//  Created by jhou on 11/5/23.
//

import SwiftUI

struct EventDetailView: View {
  var event: Event
  var body: some View {
    VStack(alignment: .center) {
      Text(event.name).font(.title).fontWeight(.heavy).padding(20).frame(alignment: .leading)
      if let url = event.url {
        Link(destination: URL(string: url)!) {}
      }
      AsyncImage(url: URL(string: event.img ?? "")) { image in image.resizable() }
        placeholder: { Color.blue.opacity(0.7) }
        .frame(width: UIScreen.main.bounds.width, height: 250)
        .aspectRatio(contentMode: .fit)
      VStack(alignment: .leading) {
        Text(timeTransform(time: event.timeStart) + "-" + timeTransform(time: event.timeEnd))
          .font(.title3).fontWeight(.bold).padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        Text(event.description ?? "")
      }.frame(maxWidth: 340, alignment: .center)
      Spacer()
    }.frame(maxWidth: .infinity)
  }
}

