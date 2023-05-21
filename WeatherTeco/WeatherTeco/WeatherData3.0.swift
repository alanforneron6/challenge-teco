//
//  WeatherData3.0.swift
//  WeatherTeco
//
//  Created by Alan Forneron on 20/05/2023.
//

import Foundation

struct WeatherData: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let daily: [DailyWeather]
}

struct DailyWeather: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let temp: Temperature
    let feelsLike: FeelsLike
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [Weathers]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double
}

struct Temperature: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct FeelsLike: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct Weathers: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
