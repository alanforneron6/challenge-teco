//
//  WeatherService.swift
//  WeatherTeco
//
//  Created by Alan Forneron on 18/05/2023.
//

import Foundation

class WeatherService {
    
    public static let shared = WeatherService()
    public let weatherApiKey = "8005b6358f5db56bec22fd743539eea1"
    
    func fetchWeather(_ location: String, completion: @escaping (WeatherDataModel?) -> Void) {
        
        guard let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(nil)
            return
        }
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(encodedLocation)&lang=es&appid=\(weatherApiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weatherData = try decoder.decode(WeatherDataModel.self, from: data)
                completion(weatherData)
            } catch {
                print(error.localizedDescription.description)
                completion(nil)
            }
        }
        
        task.resume()
    }
}
