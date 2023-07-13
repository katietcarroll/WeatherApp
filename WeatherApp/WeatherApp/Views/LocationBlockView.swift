//
//  LocationBlockView.swift
//  WeatherApp
//
//  Created by Carroll Katherine on 6/27/23.
//

import SwiftUI
import Foundation
    
// this view is used in the navigation list as a small display of weather data, it also serves as a navigation link to the LocationDescriptionView
struct LocationBlockView: View {
    @StateObject var viewModel = WeatherViewModel()
    
    var location: Location
    
    var colorToShow: Color {
        switch location.weather[0].main {
        case "Thunderstorm", "Drizzle", "Rain", "Mist", "Smoke", "Haze", "Dust", "Fog", "Sand", "Ash", "Squall", "Tornado":
            return .black
        case "Snow":
            return .white
        case "Clouds":
            return .gray
        case "Clear":
            return .blue
        default:
            return .yellow
        }
    }
    
    var imageToShow: Image {
        switch location.weather[0].main {
        case "Thunderstorm":
            return Image(systemName: "cloud.bolt.rain")
        case "Drizzle":
            return Image(systemName: "cloud.drizzle")
        case "Rain":
            return Image(systemName: "cloud.rain")
        case "Mist", "Haze", "Fog":
            return Image(systemName: "cloud.fog")
        case "Smoke":
            return Image(systemName: "smoke")
        case "Dust", "Sand", "Ash":
            return Image(systemName: "aqi.medium")
        case "Squall":
            return Image(systemName: "wind.snow")
        case "Tornado":
            return Image(systemName: "tornado")
        case "Snow":
            return Image(systemName: "snowflake")
        case "Clear":
            return Image(systemName: "sun.min")
        case "Clouds":
            return Image(systemName: "cloud")
        default:
            return Image(systemName: "sun.min")
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(colorToShow)
                .opacity(0.25)
                .frame(width: UIScreen.main.bounds.size.width, height: 100)
            HStack {
                Spacer()
                    .frame(width: 15)
                imageToShow
                    .font(.largeTitle)
                    .padding(.leading)
                VStack{
                    Text("\(location.name)")
                        .padding(.leading)
                        .font(.largeTitle)
                        .bold()
                    HStack{
                        Text("hi: \(String(format: "%.f", location.main.temp_max))ºF")
                        Text("lo: \(String(format: "%.f", location.main.temp_min))ºF")
                    }.padding(.leading)
                }
                VStack{
                    Text("\(String(format: "%.f", location.main.temp))ºF")
                        .padding(.horizontal)
                        .font(.title)
                        .bold()
                        .padding(.trailing)
                    Text("\(location.weather[0].main)")
                        .padding(.trailing)
                }
            }.padding()
        }
    }
}


// ASYNC CODE
//import SwiftUI
//import Foundation
//
//struct LocationBlockView: View {
//    @StateObject var viewModel = WeatherViewModel()
//
//    var location: Location
//
//    var colorToShow: Color {
//        switch location.weather[0].main {
//        case "Thunderstorm", "Drizzle", "Rain", "Mist", "Smoke", "Haze", "Dust", "Fog", "Sand", "Ash", "Squall", "Tornado":
//            return .black
//        case "Snow":
//            return .white
//        case "Clouds":
//            return .gray
//        case "Clear":
//            return .blue
//        default:
//            return .yellow
//        }
//    }
//
//    var imageToShow: Image {
//        switch location.weather[0].main {
//        case "Thunderstorm":
//            return Image(systemName: "cloud.bolt.rain")
//        case "Drizzle":
//            return Image(systemName: "cloud.drizzle")
//        case "Rain":
//            return Image(systemName: "cloud.rain")
//        case "Mist", "Haze", "Fog":
//            return Image(systemName: "cloud.fog")
//        case "Smoke":
//            return Image(systemName: "smoke")
//        case "Dust", "Sand", "Ash":
//            return Image(systemName: "aqi.medium")
//        case "Squall":
//            return Image(systemName: "wind.snow")
//        case "Tornado":
//            return Image(systemName: "tornado")
//        case "Snow":
//            return Image(systemName: "snowflake")
//        case "Clear":
//            return Image(systemName: "sun.min")
//        case "Clouds":
//            return Image(systemName: "cloud")
//        default:
//            return Image(systemName: "sun.min")
//        }
//    }
//
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 20)
//                .foregroundColor(colorToShow)
//                .opacity(0.25)
//                .frame(width: UIScreen.main.bounds.size.width, height: 100)
//            HStack {
//                Spacer()
//                    .frame(width: 15)
//                imageToShow
//                    .font(.largeTitle)
//                    .padding(.leading)
//                VStack{
//                    Text("\(location.name)")
//                        .padding(.leading)
//                        .font(.largeTitle)
//                        .bold()
//                    HStack{
//                        Text("hi: \(String(format: "%.f", location.main.temp_max))ºF")
//                        Text("lo: \(String(format: "%.f", location.main.temp_min))ºF")
//                    }.padding(.leading)
//                }
//                VStack{
//                    Text("\(String(format: "%.f", location.main.temp))ºF")
//                        .padding(.horizontal)
//                        .font(.title)
//                        .bold()
//                        .padding(.trailing)
//                    Text("\(location.weather[0].main)")
//                        .padding(.trailing)
//                }
//            }.padding()
//        }
//    }
//}
