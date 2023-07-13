//
//  LocationDescriptionView.swift
//  WeatherApp
//
//  Created by Carroll Katherine on 6/27/23.
//

import SwiftUI
import Foundation

// This view serves as the main description view for any searched city on the navigation list. It contains formatted data from the Location object 

struct LocationDescriptionView: View {
    var location: Location
    @StateObject var viewModel = WeatherViewModel()
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
                .opacity(0.25)
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            VStack {
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(location.weather[0].icon)@2x.png"))
                ZStack {
                    Text("\(location.name)")
                        .font(.largeTitle)
                        .bold()
                        
                }
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .foregroundColor(.blue)
                    .opacity(0.25)
                    .frame(width: UIScreen.main.bounds.size.width, height: 75)
                ZStack {
                    HStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.blue)
                            .opacity(0.25)
                            .frame(width: UIScreen.main.bounds.size.width*2/3, height: 50)
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.blue)
                            .opacity(0.25)
                            .frame(width: UIScreen.main.bounds.size.width/3, height: 50)
                    }
                    HStack {
                        Spacer()
                            .frame(width: 7)
                        Text("Current Temperature:")
                        Text("\(String(format: "%.f", location.main.temp))ºF")
                            .font(.title)
                            .bold()
                        Spacer()
                        VStack {
                            Text("hi: \(String(format: "%.f", location.main.temp_max))ºF")
                            Text("lo: \(String(format: "%.f", location.main.temp_min))ºF")
                        }
                        Spacer()
                            .frame(width: 30)
                    }
                }
                HStack {
                    ZStack {
                        HStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.blue)
                                .opacity(0.25)
                                .frame(width: UIScreen.main.bounds.size.width/2, height: 70)
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.blue)
                                .opacity(0.25)
                                .frame(width: UIScreen.main.bounds.size.width/2, height: 70)
                        }
                        
                        HStack {
                            Spacer().frame(width: 15)
                            VStack {
                                // Text("Sunrise: \(try viewModel.getSuntime(unixSuntime: location.sys.sunrise)) AM")
                                // Text("Sunset: \(try viewModel.getSuntime(unixSuntime: location.sys.sunset))PM")
                                Text("Weather Description:")
                                Text("\(location.weather[0].description)")
                                
                            }
                            Spacer()
                            VStack{
                                Text("Feels Like:")
                                    .bold()
                                Text("\(String(format: "%.f", location.main.temp_min))ºF")
                                    .bold()
                                    .font(.title)
                            }
                            Spacer().frame(width: 50)
                        }
                    }
                }
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.blue)
                            .opacity(0.25)
                            .frame(width: UIScreen.main.bounds.size.width, height: 70)
                        HStack{
                            VStack{
                                Text("Humidity: \(location.main.humidity)%")
                                Text("Cloudiness: \(location.clouds.all)%")
                                
                            }
                            Spacer().frame(width: 70)
                            VStack{
                                Text("Wind Speed: \(String(format: "%.f", location.wind.speed)) mph")
                                Text("Wind Direction: \(location.wind.deg)º")
                            }
                        }
                    }
                }
                Spacer()
                    .frame(height: 250)
            }
        }
    }
}

// ASYNC CODE
//import SwiftUI
//import Foundation
//
//struct LocationDescriptionView: View {
//    var location: Location
//    @StateObject var viewModel = WeatherViewModel()
//    var body: some View { // could separate out into multiple "some View" vars
//        ZStack {
//            RoundedRectangle(cornerRadius: 15)
//                .foregroundColor(.white)
//                .opacity(0.25)
//                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
//            VStack {
//                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(location.weather[0].icon)@2x.png"))
//                ZStack {
//                    Text("\(location.name)")
//                        .font(.largeTitle)
//                        .bold()
//
//                }
//                    .clipShape(RoundedRectangle(cornerRadius: 15))
//                    .foregroundColor(.blue)
//                    .opacity(0.25)
//                    .frame(width: UIScreen.main.bounds.size.width, height: 75)
//                ZStack {
//                    HStack{
//                        RoundedRectangle(cornerRadius: 15)
//                            .foregroundColor(.blue)
//                            .opacity(0.25)
//                            .frame(width: UIScreen.main.bounds.size.width*2/3, height: 50)
//                        RoundedRectangle(cornerRadius: 15)
//                            .foregroundColor(.blue)
//                            .opacity(0.25)
//                            .frame(width: UIScreen.main.bounds.size.width/3, height: 50)
//                    }
//                    HStack {
//                        Spacer()
//                            .frame(width: 7)
//                        Text("Current Temperature:")
//                        Text("\(String(format: "%.f", location.main.temp))ºF")
//                            .font(.title)
//                            .bold()
//                        Spacer()
//                        VStack {
//                            Text("hi: \(String(format: "%.f", location.main.temp_max))ºF")
//                            Text("lo: \(String(format: "%.f", location.main.temp_min))ºF")
//                        }
//                        Spacer()
//                            .frame(width: 30)
//                    }
//                }
//                HStack {
//                    ZStack {
//                        HStack {
//                            RoundedRectangle(cornerRadius: 15)
//                                .foregroundColor(.blue)
//                                .opacity(0.25)
//                                .frame(width: UIScreen.main.bounds.size.width/2, height: 70)
//                            RoundedRectangle(cornerRadius: 15)
//                                .foregroundColor(.blue)
//                                .opacity(0.25)
//                                .frame(width: UIScreen.main.bounds.size.width/2, height: 70)
//                        }
//
//                        HStack {
//                            Spacer().frame(width: 15)
//                            VStack {
//                                // Text("Sunrise: \(try viewModel.getSuntime(unixSuntime: location.sys.sunrise)) AM")
//                                // Text("Sunset: \(try viewModel.getSuntime(unixSuntime: location.sys.sunset))PM")
//                                Text("Weather Description:")
//                                Text("\(location.weather[0].description)")
//
//                            }
//                            Spacer()
//                            VStack{
//                                Text("Feels Like:")
//                                    .bold()
//                                Text("\(String(format: "%.f", location.main.temp_min))ºF")
//                                    .bold()
//                                    .font(.title)
//                            }
//                            Spacer().frame(width: 50)
//                        }
//                    }
//                }
//                HStack {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 15)
//                            .foregroundColor(.blue)
//                            .opacity(0.25)
//                            .frame(width: UIScreen.main.bounds.size.width, height: 70)
//                        HStack{
//                            VStack{
//                                Text("Humidity: \(location.main.humidity)%")
//                                Text("Cloudiness: \(location.clouds.all)%")
//
//                            }
//                            Spacer().frame(width: 70)
//                            VStack{
//                                Text("Wind Speed: \(String(format: "%.f", location.wind.speed)) mph")
//                                Text("Wind Direction: \(location.wind.deg)º")
//                            }
//                        }
//                    }
//                }
//                Spacer()
//                    .frame(height: 250)
//            }
//        }
//    }
//}
