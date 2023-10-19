//
//  Itinerary.swift
//  itinerary-app
//
//  Created by jhou on 10/17/23.
//

import SwiftUI

struct Itinerary: Identifiable, Codable {
  
  var id: UUID
  var location: String
  var img: String?
  var isCurrent: Bool
  var days: [Day]?
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case location
    case img
    case isCurrent
    case days
  }
  
}
