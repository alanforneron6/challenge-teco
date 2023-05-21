//
//  LocationManager.swift
//  WeatherTeco
//
//  Created by Alan Forneron on 20/05/2023.
//

import CoreLocation

class LocationManager: NSObject {
    private let geocoder = CLGeocoder()
    
    func geocodeAddress(_ address: String, completion: @escaping (Result<CLPlacemark, Error>) -> Void) {
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let placemark = placemarks?.first {
                completion(.success(placemark))
            } else {
                let error = NSError(domain: "Geocode Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "No se encontraron coordenadas para la ciudad especificada."])
                completion(.failure(error))
            }
        }
    }
}

