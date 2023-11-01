//
//  Event.swift
//  itinerary-app
//
//  Created by jhou on 10/17/23.
//

import Foundation
enum EventType: String, Codable {
    case meal
    case attraction
    case travel
}

struct Event: Identifiable, Codable {
  
  var id: UUID
  var name: String
  var description: String?
  var img: String?
  var type: EventType
  var latitude: Double?
  var longitude: Double?
  var timeStart: String?
  var timeEnd: String?
  var url: String?
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case img
    case type
    case latitude
    case longitude
    case timeStart
    case timeEnd
    case url
  }
}
