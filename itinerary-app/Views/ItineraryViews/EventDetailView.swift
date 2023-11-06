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
      AsyncImage(url: URL(string: "https://cdn.britannica.com/74/65574-050-B1A02E0C/Downtown-Pittsburgh-Pennsylvania-Fort-Pitt-Bridge-Monongahela.jpg")) { image in image.resizable() }
        placeholder: { Color.blue.opacity(0.7) }
        .frame(width: UIScreen.main.bounds.width, height: 250)
        .aspectRatio(contentMode: .fit)
      VStack(alignment: .leading) {
        Text((event.timeStart ?? "Unknown time") + "-" + (event.timeEnd ?? "Unknown time"))
          .font(.title3).fontWeight(.bold).padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        Text(event.description ?? "")
      }.frame(maxWidth: 340, alignment: .center)
      Spacer()
    }.frame(maxWidth: .infinity)
  }
}

#Preview {
  EventDetailView(event: Event(id: UUID(), name: "BUS", type: .attraction))
}
