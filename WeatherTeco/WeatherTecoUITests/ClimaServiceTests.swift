//
//  ClimaServiceTests.swift
//  WeatherTeco
//
//  Created by Alan Forneron on 19/05/2023.
//

import XCTest

class ClimaServiceTests: XCTestCase {

    func testFetchWeather() {
        let expectation = self.expectation(description: "FetchWeatherExpectation")
        let location = "London"
        WeatherService.shared.fetchWeather(location) { (weatherResponse) in
            XCTAssertNotNil(weatherResponse, "Weather response should not be nil")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
