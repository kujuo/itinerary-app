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
      Text(event.name).font(.title).fontWeight(.heavy)/*.frame(alignment: .leading)/*.padding(20)*/*/
      if let url = event.url {
        Link(destination: URL(string: url)!) {}
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
      Spacer()
    }
  }
}

