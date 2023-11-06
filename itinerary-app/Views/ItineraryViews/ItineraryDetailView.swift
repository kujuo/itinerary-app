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
  var saved: Bool
  var body: some View {
    ScrollView {
      VStack(/*alignment: .leading*/) {
        ZStack(alignment: .topLeading){
          AsyncImage(url: URL(string: "https://cdn.britannica.com/74/65574-050-B1A02E0C/Downtown-Pittsburgh-Pennsylvania-Fort-Pitt-Bridge-Monongahela.jpg")) { image in image.resizable() }
            placeholder: { Color.blue.opacity(0.7) }
            .frame(width: UIScreen.main.bounds.width, height: 250)
            .aspectRatio(contentMode: .fit)
          Rectangle()
            .fill(LinearGradient(
                gradient: .init(colors: [Color.black.opacity(0.9), Color.black.opacity(0.4), Color.white.opacity(0.2), Color.black.opacity(0.3)]),
                startPoint: .init(x: 0.5, y: 0.0),
                endPoint: .init(x: 0.5, y: 1)
            ))
            .frame(width: UIScreen.main.bounds.width, height: 250)
          VStack (alignment: .leading){
            Text(itinerary.location).font(.title).fontWeight(.heavy).foregroundColor(Color.white).padding(10).fixedSize(horizontal: false, vertical: true)
            Spacer()
            HStack {
              Spacer()
              if (saved) {
                Button {} label: {
                  ButtonWithIcon(text: "Saved", systemImage: "checkmark.circle", color: Color.green)
                }
              }
              else {
                Button {} label: {
                  ButtonWithIcon(text: "Save?", systemImage: "questionmark.circle", color: Color.red)
                }
              }
            }
          }
        }.frame(maxHeight: 250)

        VStack(alignment: .leading) {
          if (itinerary.days != nil) {
            ForEach(itinerary.days!) { day in
              Text("Day " + day.dayNumber.description)
    //          NavigationView {
                ForEach(day.events!) {
                  event in
  //                HStack {
                    EventNavView(event: event)
  //                }
                }
            }
          }
        }
        Spacer()
      }.frame(maxWidth: .infinity/*, alignment: .topLeading*/)

    }
  }
}

struct ButtonWithIcon: View {
  let text: String
  let systemImage: String
  let color: Color
  var body: some View {
    HStack {
      HStack {
        Image(systemName: systemImage)
        Text(text)
      }.padding(10)
    }.background(color).cornerRadius(5).padding(20).foregroundColor(Color.black)
  }
}
