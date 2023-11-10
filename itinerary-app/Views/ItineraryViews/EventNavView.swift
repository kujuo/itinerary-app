//
//  EventView.swift
//  itinerary-app
//
//  Created by jhou on 11/5/23.
//

import SwiftUI
import FirebaseStorage


struct EventNavView: View {
  @State var imgURL: URL? = nil
  var event: Event
  var body: some View {
    switch event.type {
    case .restaurant:
      Link(destination: URL(string: event.url ?? "https://www.google.com/maps")!) {
        Meal(event: event).foregroundColor(Color.black)
      }
    case .attraction:
      NavigationLink(destination: EventDetailView(event: event)) {
        Attraction(event: event)
      }
    case .geo:
      NavigationLink(destination: EventDetailView(event: event)) {
        Attraction(event: event)
      }
    case .travel:
      Link(destination: URL(string: event.url ?? "https://www.google.com/maps")!) {
        Travel(event: event)
      }.foregroundColor(Color.black)
    }
  }
}

struct Meal: View {
  var event: Event
  var body: some View {
    VStack(alignment: .center) {
      ZStack(alignment: .topLeading){
        Rectangle()
          .fill(lightBlueColor.opacity(0.9))
          .frame(width: 340, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        HStack {
          VStack (alignment: .leading){
            Text(timeTransform(time: event.timeStart) + "-" + timeTransform(time: event.timeEnd))
              .font(.title3)
            Text("Meal: " + event.name)
              .font(.title3).fontWeight(.heavy)
              .multilineTextAlignment(.leading)
            Spacer()
          }
          Spacer()
          VStack {
            Spacer()
            Image(systemName: "chevron.forward.circle")
              .resizable()
              .frame(width: 30, height: 30)
            Spacer()
          }
        }.padding(10)
      }.frame(maxWidth: 340, maxHeight: 100)
    }
  }
}

struct Attraction: View {
  @State var imgURL: URL? = nil
  var event: Event
  var body: some View {
    VStack(alignment: .center) {
      ZStack(alignment: .topLeading){
        AsyncImage(url: imgURL) { image in image.resizable() }
      placeholder: { lightBlueColor.opacity(0.9) }
          .frame(width: 340, height: 200)
          .aspectRatio(contentMode: .fit)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        Rectangle()
          .fill(LinearGradient(
              gradient: .init(colors: [Color.black.opacity(0.9), Color.black.opacity(0.4), Color.black.opacity(0.1), Color.white.opacity(0.2), Color.black.opacity(0.3)]),
              startPoint: .init(x: 0.5, y: 0.0),
              endPoint: .init(x: 0.5, y: 1)
          ))
          .frame(width: 340, height: 200)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        HStack {
          VStack (alignment: .leading){
            Text(timeTransform(time: event.timeStart) + "-" + timeTransform(time: event.timeEnd))
              .font(.title3)
              .foregroundColor(Color.white)
            Text(event.name)
              .font(.title3).fontWeight(.heavy)
              .foregroundColor(Color.white).multilineTextAlignment(.leading)
//              .fixedSize(horizontal: false, vertical: true)
            Spacer()
          }/*.padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 0))*/
          Spacer()
          VStack {
            Spacer()
            Image(systemName: "chevron.forward.circle")
              .resizable()
              .frame(width: 30, height: 30)
              .tint(Color.white)
            Spacer()
          }
        }.padding(10)
      }.frame(maxWidth: 340, maxHeight: 200)
    }
  }
}

struct Travel: View {
  var event: Event
  var body: some View {
    HStack {
      Spacer()
      Text(timeTransform(time: event.timeStart) + "-" + timeTransform(time: event.timeEnd))
        .font(.caption)
//        .border(Color.green , width: 2.0)
      Image(systemName: "ellipsis")
//        .resizable()
        .rotationEffect(.degrees(90))
//        .frame(height: 25)
//        .border(Color.green , width: 2.0)
      Text("Travel: " + event.name)
      Spacer()
      VStack {
        Spacer()
        Image(systemName: "chevron.forward.circle")
          .resizable()
          .frame(width: 30, height: 30)
        Spacer()
      }.padding(10)
    }.frame(maxWidth: 340)
  }
}

