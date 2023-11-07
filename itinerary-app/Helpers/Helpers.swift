//
//  Helpers.swift
//  itinerary-app
//
//  Created by jhou on 11/5/23.
//

import Foundation

func timeTransform(time: String?) -> String {
  if let t = time {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HHmm"
    var dateFromStr = dateFormatter.date(from: t)!

  //  // Time with date in long format
  //  dateFormatter.dateFormat = "hh:mm:ss a 'on' MMMM dd, yyyy"
  //  var timeInLongFromDate = dateFormatter.string(from: dateFromStr)
  //  print(timeInLongFromDate)
    dateFormatter.dateFormat = "hh:mm a"
    var timeFromDate = dateFormatter.string(from: dateFromStr)
    return timeFromDate
  }
  else { return "Unknown time" }
}

