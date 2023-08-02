//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Carroll Katherine on 6/27/23.
//

import Foundation

// This is the ViewModel that performs all the API calls and data storage, running the background logic of the three views.

// code coverage

final class WeatherViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    
    @Published var textFieldValue: String = ""
    
    @Published var location: Location = Location.zero
    
    @Published var locationSet: [Location] = []
    
    
    // look up how to unwrap nested closures, avoiding nested completion blocks -- completion chaining
    func getWeather(completion: @escaping (Location) -> Void) {
        getCoordUrl { coordUrl in
            self.getCoordJson(coordUrl: coordUrl, completion: { json in
                self.parseCoordinates(json: json, completion: { coords in
                    self.getLocationUrl(coordinates: coords[0], completion: { locationUrl in
                        self.getLocationJson(locationUrl: locationUrl, completion: { json in
                            self.parseLocation(json: json, completion: { location in
                                self.location = location
                                completion(location)
                            })
                        })
                    })
                })
            })
        }
    }
    
    func getCoordUrl(completion: @escaping (URL) -> Void) {
        let coordBaseUrl = "https://api.openweathermap.org/geo/1.0/direct"
        let apiKey = ## ENTER API KEY HERE
        var coordComponents = URLComponents(string: coordBaseUrl)
        coordComponents?.queryItems = [
            URLQueryItem(name: "q", value: textFieldValue),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "exclude", value: "local_names")
        ]
        
        guard let coordUrl = coordComponents?.url else {
            errorMessage = "Cannot get weather data"
            return
        }
        completion(coordUrl)
    }
    
    func getCoordJson(coordUrl: URL, completion: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: coordUrl) { (data, _, _) in
            guard let coordData = data else {
                return
            }
            DispatchQueue.main.async {
                completion(coordData)
            }
        }.resume()
    }
    
    func parseCoordinates(json: Data, completion: @escaping ([Coordinates]) -> Void) {
        DispatchQueue.global().async {
            do {
                let decodedCoordData = try JSONDecoder().decode([Coordinates].self, from: json)
                let coordinates = decodedCoordData
                
                DispatchQueue.main.async {
                    completion(coordinates)
                }
            } catch {
                print("Error decoding JSON data")
            }
        }
    }
    
    func getLocationUrl(coordinates: Coordinates, completion: @escaping (URL) -> Void) {
        let locationBaseUrl = "https://api.openweathermap.org/data/2.5/weather"
        let locationApiKey = "75dc3ad564ad0eebf79a36e8d462498e"
        
        var locationComponents = URLComponents(string: locationBaseUrl)
        locationComponents?.queryItems = [
            URLQueryItem(name: "lat", value: "\(coordinates.lat)"),
            URLQueryItem(name: "lon", value: "\(coordinates.lon)"),
            URLQueryItem(name: "appid", value: locationApiKey),
            URLQueryItem(name: "units", value: "imperial")
        ]
        guard let locationUrl = locationComponents?.url else {
            errorMessage = "Cannot get weather data"
            return
        }
        completion(locationUrl)
    }
    
    func getLocationJson(locationUrl: URL, completion: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: locationUrl) { (data, _, _) in
            guard let locationData = data else {
                return
            }
            DispatchQueue.main.async {
                completion(locationData)
            }
        }.resume()
    }
    
    func parseLocation(json: Data, completion: @escaping (Location) -> Void) {
        DispatchQueue.global().async {
            do {
                let decodedLocationData = try JSONDecoder().decode(Location.self, from: json)
                let location = decodedLocationData
                
                DispatchQueue.main.async {
                    self.location = location
                    print("\(location.name), \(location.main.temp)ºF")
                    completion(location)
                }
            } catch {
                print("Error decoding JSON data")
            }
        }
    }
    
    func searchButtonSend(completion: @escaping () -> Void) {
        addNewLocation { location in
            self.populateSet {
                completion()
            }
        }
    }
    
    func addNewLocation(completion: @escaping (Location) -> Void) {
        getWeather { loc in
            completion(loc)
        }
    }
    
    func populateSet(completion: @escaping () -> Void) {
        if locationSet.contains(location) {
            locationSet[locationSet.firstIndex(of: location) ?? 0] = location
        }
        else {
            locationSet.append(location)
        }
    }
    
    func refresh(locale: String, completion: @escaping () -> Void) {
        textFieldValue = locale
        searchButtonSend {
            self.clearTextField()
        }
    }
    
    func refreshAll(completion: @escaping () -> Void) {
        for location in locationSet {
            refresh(locale: location.name) {
                self.clearTextField()
            }
        }
    }
    
    func refreshAllWrapper() {
        if !locationSet.isEmpty {
                refreshAll {
                    self.clearTextField()
                }
        }
    }
    
    func clearTextField() {
        textFieldValue = ""
    }
    
    // test removeLocations
    func removeLocations(atOffsets offsets: IndexSet) {
        let sortedIndexes = offsets.sorted().reversed()
        sortedIndexes.forEach { index in
            let locationToRemove = index
            locationSet.remove(at: locationToRemove)
        }
    }
}


// ASYNC CODE
//import Foundation
//
//@MainActor final class WeatherViewModel: ObservableObject {
//
//    @Published var textFieldValue: String = ""
//
//    @Published private var coordinates: [Coordinates] = []
//
//    @Published var location: Location = Location.zero
//
//    @Published var locationSet: [Location] = []
//
//    // could break this into multiple parts - get location, json decoder, and get weather and update views
//    // master get weather data that calls each individual function once each completion is done (completion blocks in the master)
//    // or have them chain to each other by calling the next function in its completion block (better than nested completion blocks in the master)
//    // url component func that returns url, this is a testable func
//
//    func getWeatherData() async throws -> Location {
//        let coordBaseUrl = "https://api.openweathermap.org/geo/1.0/direct"
//        let apiKey = "75dc3ad564ad0eebf79a36e8d462498e"
////        let encodedCity = textFieldValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//
//        var coordComponents = URLComponents(string: coordBaseUrl)
//        coordComponents?.queryItems = [
//            URLQueryItem(name: "q", value: textFieldValue),
//            URLQueryItem(name: "appid", value: apiKey),
//            URLQueryItem(name: "exclude", value: "local_names")
//        ]
//
//        guard let coordUrl = coordComponents?.url else {
//            fatalError("Cannot get weather data")
//        } // test by passing in a bad base url
//
//        let (coordData, _) = try await URLSession.shared.data(from: coordUrl) // try completion blocks
//
//        do {
//            let decodedCoordData = try JSONDecoder().decode([Coordinates].self, from: coordData)
//            self.coordinates = decodedCoordData
//        }
//        // test this one with serialized json to check that optionals are actually optional, make sure things decode properly and optionals are decoded if they are present
//
//        catch {
//            print("Error decoding JSON data")
//        }
//
//        // split here, single responsibility functions + more testability + comprehensibility
//
//        let lat: Double = coordinates[0].lat
//        let lon: Double = coordinates[0].lon // pass in lat and lon into new func, this is testable
//
//        let locationBaseUrl = "https://api.openweathermap.org/data/2.5/weather"
//        let locationApiKey = "75dc3ad564ad0eebf79a36e8d462498e"
//
//        var locationComponents = URLComponents(string: locationBaseUrl)
//            locationComponents?.queryItems = [
//                URLQueryItem(name: "lat", value: "\(lat)"),
//                URLQueryItem(name: "lon", value: "\(lon)"),
//                URLQueryItem(name: "appid", value: locationApiKey),
//                URLQueryItem(name: "units", value: "imperial")
//            ]
//
//        guard let locationUrl = locationComponents?.url else {
//            fatalError("Cannot get weather data") // look into other error options, don't want app to crash (return error using exceptions or results, etc to display error messages rather than crashing)
//        }
//
//        let (locationData, _) = try await URLSession.shared.data(from: locationUrl)
//        do {
//            let decodedLocationData = try JSONDecoder().decode(Location.self, from: locationData)
//            self.location = decodedLocationData
//        }
//        catch {
//            print("Error decoding JSON data")
//        }
//        print("\(location.name), \(location.main.temp)ºF")
//
//        return location // use a result and completion block
//
//    }
//
//    // can test this to confirm proper updating
//    // dependency injection:
//    // protocol: set of methods/properties that an object needs to implement, can be helpful for testing. Don't need to understand implementation to write the code
//    // break down into get data and update locationSet = storeThisLocation func to take a location in, makes it testable to see if the set is being updated or used correctly
//    func send() async throws { // change to a better name - more informative naming
//        location = try await getWeatherData()
//        if locationSet.contains(location) {
//            locationSet[locationSet.firstIndex(of: location)!] = location
//            // don't use !, find a better way (extension for safe look up or return nil)
//            // set documentation: set.update function with hashable
//        }
//        if !locationSet.contains(location) { // else statement
//            locationSet.append(location)
//        }
//    }
//
//    func refresh(locale: String) async throws {
//        textFieldValue = locale
//        try await send()
//        clearTextField()
//    }
//
//    // async - practice with completion blocks instead
//
//    func refreshWrapper(locale: String) {
//        Task {
//            do {
//                try await refresh(locale: locale)
//            }
//            catch {
//                print("Refresh Error")
//            }
//        }
//    }
//
//    func clearTextField() {
//        textFieldValue = ""
//    }
    
//    func getSuntime(unixSuntime: Int) async throws -> Date {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "hh:mm a"
//
//        let suntime = Date(timeIntervalSince1970: TimeInterval(unixSuntime))
//
//        print(suntime)
//
//        return suntime
//    }
// }

