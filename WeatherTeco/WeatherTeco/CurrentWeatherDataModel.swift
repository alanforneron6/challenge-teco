//
//  WeatherDataModel.swift
//  WeatherTeco
//
//  Created by Alan Forneron on 18/05/2023.
//

import Foundation

struct CurrentWeatherDataModel: Decodable {
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let icon: String
    
    private enum CodingKeys: String, CodingKey {
        case description = "description"
        case icon
    }
}

struct LargeWeatherDataModel: Decodable {
    let coord: CoordModel
    let weather: [LargeWeatherModel]
    let base: String
    let main: MainModel
    let visibility: Int
    let wind: WindModel
    let clouds: CloudsModel
    let dt: Int
    let sys: SysModel
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct CoordModel: Decodable {
    let lon: Double
    let lat: Double
}

struct LargeWeatherModel: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    var iconURL: URL {
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        return URL(string: urlString)!
    }
}

struct MainModel: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct WindModel: Decodable {
    let speed: Double
    let deg: Int
}

struct CloudsModel: Decodable {
    let dt: Int
}

struct SysModel: Decodable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
