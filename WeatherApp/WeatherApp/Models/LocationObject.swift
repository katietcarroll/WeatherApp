//
//  M_Weather.swift
//  WeatherApp
//
//  Created by Carroll Katherine on 6/16/23.
//

import Foundation

// this object stores all the decoded weather data from the OpenWeather API call
struct Location: Codable, Hashable {
    
    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Double
        let humidity: Int
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }
    
    struct Clouds: Codable {
        let all: Int
    }
    
    struct Sys: Codable {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Int
        let sunset: Int
    }
    
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    static let zero = Location(
            coord: Coord(lon: 0.0, lat: 0.0), // make location equatable by lat and lon rather than name 
            weather: [],
            base: "",
            main: Main(
                temp: 0.0,
                feels_like: 0.0,
                temp_min: 0.0,
                temp_max: 0.0,
                pressure: 0.0,
                humidity: 0
            ),
            visibility: 0,
            wind: Wind(speed: 0.0, deg: 0),
            clouds: Clouds(all: 0),
            dt: 0,
            sys: Sys(type: 0, id: 0, country: "", sunrise: 0, sunset: 0),
            timezone: 0,
            id: 0,
            name: "",
            cod: 0
        )
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        // Compare all the properties for equality
        return lhs.name == rhs.name
    }
}

