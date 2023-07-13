//
//  ContentPreviews.swift
//  WeatherApp
//
//  Created by Carroll Katherine on 6/27/23.
//

import SwiftUI
import Foundation
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LocationBlockView(location: Location(
            coord: Location.Coord(lon: -87.6189, lat: 41.8758),
            weather: [Location.Weather(id: 803, main: "Clouds", description: "broken clouds", icon: "04d")],
            base: "stations",
            main: Location.Main(
                temp: 88.03,
                feels_like: 81.09,
                temp_min: 73.33,
                temp_max: 85.32,
                pressure: 1013,
                humidity: 44
            ),
            visibility: 10000,
            wind: Location.Wind(speed: 11.5, deg: 100),
            clouds: Location.Clouds(all: 75),
            dt: 1687191378,
            sys: Location.Sys(type: 2, id: 2011010, country: "US", sunrise: 1687169704, sunset: 1687224510),
            timezone: -18000,
            id: 4887398,
            name: "Chicago",
            cod: 200
        ) )
    }
}
