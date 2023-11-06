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
    case .meal:
      Link(destination: URL(string: "https://www.apple.com")!) {
        AsyncImage(url: URL(string: "https://www.apple.com")) { image in image.resizable() } 
          placeholder: { Color.blue.opacity(0.7) }
          .frame(width: 300, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
          .aspectRatio(contentMode: .fit)
      }
    case .attraction:
      NavigationLink(destination: EventDetailView(event: event)) {
        Text(event.name)
        AsyncImage(url: URL(string: "https://www.apple.com")) { image in image.resizable() } placeholder: { Color.blue.opacity(0.7) }
          .frame(width: 200, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
          .aspectRatio(contentMode: .fit)
      }
    case .travel:
      Link(destination: URL(string: "https://www.apple.com")!) {
          Image(systemName: "link.circle.fill")
              .font(.largeTitle)
      }
    }
//    {
//    case .single(let singleContent):
//        SingleView(content: singleContent)
//    case .split(let splittableContentLeft, let splittableContentRight):
//        HSplitView {
//            SplittableView(content: splittableContentLeft)
//            SplittableView(content: splittableContentRight)
//        }
//    }
  }
  
  func getURL(path: String) {
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
          imgURL = downloadURL
        }
      }
    })
  }
}

