//
//  ItineraryRowView.swift
//  itinerary-app
//
//  Created by jhou on 10/24/23.
//

import Foundation
import Foundation
import SwiftUI
import FirebaseStorage

struct ItineraryNavView: View {
  var itinerary: Itinerary
  var sizeHeight: CGFloat
  let sizeWidth: CGFloat = 340
  var isCurrent: Bool
  var saved: Bool
  
  @State var imgURL: URL? = nil
  
  init(itinerary: Itinerary, isCurrent: Bool, saved: Bool, imgURL: URL? = nil) {
    self.itinerary = itinerary
    self.isCurrent = isCurrent
    self.sizeHeight = isCurrent ? 200 : 100
    self.saved = saved
    self.imgURL = imgURL
  }
  
  var body: some View {
    NavigationLink(
      destination: ItineraryDetailView(itinerary: itinerary, saved: saved)) {
        VStack (alignment: .leading, content: {
          ZStack {
            // Image
            AsyncImage(url: imgURL) { image in image.resizable() } placeholder: { Color.blue.opacity(0.7) }
              .frame(width: sizeWidth, height: sizeHeight)
              .clipShape(RoundedRectangle(cornerRadius: 20))
              .aspectRatio(contentMode: .fit)
            // Gradient on top of the image
            Rectangle()
                .fill(LinearGradient(
                  gradient: .init(colors: [Color.black.opacity(0.5), Color.white.opacity(0.2), Color.black.opacity(0.2)]),
                  startPoint: .init(x: 0.5, y: 0.0),
                  endPoint: .init(x: 0.5, y: 1)
                ))
                .frame(width: sizeWidth, height: sizeHeight)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            // Text within the button
            HStack {
              if (self.isCurrent) {
                VStack(alignment: .leading) {
                  Text(itinerary.location).frame(alignment: .leading)
                    .fontWeight(.bold).foregroundColor(Color.white)
                    .font(.title)
                  Spacer()
                  Text("2 weeks").frame(alignment: .leading)
                    .fontWeight(.bold).foregroundColor(Color.white)
                    .font(.title)
                }.padding(10)
              }
              else {
                VStack(alignment: .leading) {
                  Text(itinerary.location).frame(alignment: .leading)
                    .fontWeight(.bold).foregroundColor(Color.white)
                    .font(.title3)
                  Spacer()
                  Text("2 weeks").frame(alignment: .leading)
                    .fontWeight(.bold).foregroundColor(Color.white)
                    .font(.title3)
                }.padding(10)
              }
              Spacer()
              // Menu
              VStack {
                Menu {
                    Button("Set as New Current") {  }
                    Button("Delete", role: .destructive) {  }
                } label: {
                  Label("", systemImage: "ellipsis").foregroundColor(Color.white)
//                    .border(Color.green , width: 2.0)
                    .font(.system(size: 25))
                }.padding(10)
                Spacer()
              }
            }.frame(alignment: .leading)
          }
        })
        .frame(maxWidth: sizeWidth, maxHeight: sizeHeight)
        // first VStack
      }
      .onAppear(perform: {
        getURL(path: "DSC_0387.jpeg") { urlString in // <-- here
          self.imgURL = urlString
          print("---> urlString: \(urlString)" ) // <-- here
      }
      })
  }
}

func getURL(path: String, completion: @escaping (URL) -> Void) {
  let storageRef = Storage.storage().reference()
  let starsRef = storageRef.child(path)
  // Fetch the download URL
  
  starsRef.downloadURL(completion: { (url, error) in
    if let error = error {
      // Handle any errors
      print("Error getting download URL: \(error.localizedDescription)")
    } else {
      // Get the download URL for 'images/stars.jpg'
      if let downloadURL = url {
        completion(downloadURL)
//          imgURL = downloadURL
      }
    }
  })
}

