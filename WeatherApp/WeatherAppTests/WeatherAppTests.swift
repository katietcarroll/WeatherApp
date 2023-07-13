//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Carroll Katherine on 6/14/23.
//

// TDD test driven development

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {
    
    var viewModel: WeatherViewModel! // implicitly unwrapped optional, reset the VM in setUpWithError each time

    override func setUpWithError() throws {
        viewModel = WeatherViewModel()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testGetCoordUrl() throws {
        let expectation = XCTestExpectation(description: "Return complete URL for geocoder API call, insert the city of interest into the URL Builder and return correct built URL") // better description
        var capturedCoordUrl: URL?
        
        let cityName = "London"
        
        viewModel.textFieldValue = cityName
        viewModel.getCoordUrl { url in
            capturedCoordUrl = url
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(capturedCoordUrl)
        
        let expectedUrl = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=London&appid=75dc3ad564ad0eebf79a36e8d462498e&exclude=local_names")
        
        XCTAssertEqual(capturedCoordUrl, expectedUrl)
    }
    
    
    func testParseCoordinates() throws {
        let expectation = XCTestExpectation(description: "Parse a Coordinates object from a JSON response from the geocoder API call")
        var capturedCoordinates: [Coordinates]?
        
        let mockData = try JSONEncoder().encode([Coordinates(name: "London", local_names: [:], lat: 51.5073219, lon: -0.1276474, country: "GB", state: "England")])
    
        self.viewModel.parseCoordinates(json: mockData) { coordinates in
               capturedCoordinates = coordinates
               expectation.fulfill()
           }
        let expectedCoordinates = [Coordinates(name: "London", local_names: [:], lat: 51.5073219, lon: -0.1276474, country: "GB", state: "England")]
        
        self.wait(for: [expectation], timeout: 5.0)
          XCTAssertNotNil(capturedCoordinates)
          XCTAssertEqual(capturedCoordinates, expectedCoordinates)
      }
    
    
    func testGetLocationUrl() throws {
        let expectation = XCTestExpectation(description: "Return complete URL for current weather API call, insert the coordinates object into the URL Builder and return correct built URL")
        var capturedLocationUrl: URL?
        
        let coordinates = Coordinates(name: "London", local_names: [:], lat: 51.5073219, lon: -0.1276474, country: "GB", state: "England")
        
        viewModel.getLocationUrl(coordinates: coordinates) { url in
            capturedLocationUrl = url
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(capturedLocationUrl)
        
        let expectedUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=51.5073219&lon=-0.1276474&appid=75dc3ad564ad0eebf79a36e8d462498e&units=imperial")
        
        XCTAssertEqual(capturedLocationUrl, expectedUrl)
    }
    
    func testParseLocation() throws {
        let expectation = XCTestExpectation(description: "Parse a Location object from a JSON response from the current weather API call")
        var capturedLocation: Location?
        
        let mockData = try JSONEncoder().encode(Location(
            coord: Location.Coord(lon: -0.1276474, lat: 51.5073219),
            weather: [],
            base: "",
            main: Location.Main(
                temp: 0.0,
                feels_like: 0.0,
                temp_min: 0.0,
                temp_max: 0.0,
                pressure: 0.0,
                humidity: 0
            ),
            visibility: 0,
            wind: Location.Wind(speed: 0.0, deg: 0),
            clouds: Location.Clouds(all: 0),
            dt: 0,
            sys: Location.Sys(type: 0, id: 0, country: "", sunrise: 0, sunset: 0),
            timezone: 0,
            id: 0,
            name: "London",
            cod: 0
        ))
        
        let expectedLocation = Location(
            coord: Location.Coord(lon: -0.1276474, lat: 51.5073219),
            weather: [],
            base: "",
            main: Location.Main(
                temp: 0.0,
                feels_like: 0.0,
                temp_min: 0.0,
                temp_max: 0.0,
                pressure: 0.0,
                humidity: 0
            ),
            visibility: 0,
            wind: Location.Wind(speed: 0.0, deg: 0),
            clouds: Location.Clouds(all: 0),
            dt: 0,
            sys: Location.Sys(type: 0, id: 0, country: "", sunrise: 0, sunset: 0),
            timezone: 0,
            id: 0,
            name: "London",
            cod: 0
        )
 
        self.viewModel.parseLocation(json: mockData) { location in
           capturedLocation = location
           expectation.fulfill()
       }
        
        // Assert
        self.wait(for: [expectation], timeout: 5.0)
          XCTAssertNotNil(capturedLocation)
          XCTAssertEqual(capturedLocation, expectedLocation)
      }
    
    func testPopulateSet() throws {
//        let expectation = XCTestExpectation(description: "Populate View Model LocationSet with a provided Location object")
        
        let initialSet: [Location] = [Location.zero]
        viewModel.locationSet = initialSet
        
        viewModel.location = Location.zero
        self.viewModel.populateSet {
        }
        
        XCTAssertEqual(initialSet.count, viewModel.locationSet.count)
        
        viewModel.location = Location(
            coord: Location.Coord(lon: -0.1276474, lat: 51.5073219),
            weather: [],
            base: "",
            main: Location.Main(
                temp: 0.0,
                feels_like: 0.0,
                temp_min: 0.0,
                temp_max: 0.0,
                pressure: 0.0,
                humidity: 0
            ),
            visibility: 0,
            wind: Location.Wind(speed: 0.0, deg: 0),
            clouds: Location.Clouds(all: 0),
            dt: 0,
            sys: Location.Sys(type: 0, id: 0, country: "", sunrise: 0, sunset: 0),
            timezone: 0,
            id: 0,
            name: "London",
            cod: 0
        )
        self.viewModel.populateSet {
        }
        
        XCTAssertEqual(initialSet.count + 1, viewModel.locationSet.count)
    }
    
    func testRemoveLocations() throws {
        
        let london = Location(
            coord: Location.Coord(lon: -0.1276474, lat: 51.5073219),
            weather: [],
            base: "",
            main: Location.Main(
                temp: 0.0,
                feels_like: 0.0,
                temp_min: 0.0,
                temp_max: 0.0,
                pressure: 0.0,
                humidity: 0
            ),
            visibility: 0,
            wind: Location.Wind(speed: 0.0, deg: 0),
            clouds: Location.Clouds(all: 0),
            dt: 0,
            sys: Location.Sys(type: 0, id: 0, country: "", sunrise: 0, sunset: 0),
            timezone: 0,
            id: 0,
            name: "London",
            cod: 0
        )
        
        let initialSet: [Location] = [Location.zero, london]
        viewModel.locationSet = initialSet
        
        let offsetsToRemove = IndexSet(integer:0)
        viewModel.removeLocations(atOffsets: offsetsToRemove)
        
        XCTAssertEqual(viewModel.locationSet.count, 1, "Expected 1 locations after removing one")
    }
}
