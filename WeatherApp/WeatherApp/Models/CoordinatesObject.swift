//
//  CoordinatesObject.swift
//  WeatherApp
//
//  Created by Carroll Katherine on 6/27/23.
//

import Foundation

// this object stores all the decoded coordinate data from the OpenWeather geocoder API call
struct Coordinates: Codable {
    let name: String
    let local_names: [String: String]?
    let lat: Double
    let lon: Double
    let country: String
    let state: String
}


extension Coordinates: Equatable {
    static func == (lhs: Coordinates, rhs: Coordinates) -> Bool {
        // Compare all the properties for equality
        return lhs.name == rhs.name &&
        lhs.lat == rhs.lat &&
        lhs.lon == rhs.lon &&
        lhs.country == rhs.country &&
        lhs.state == rhs.state
    }
}


