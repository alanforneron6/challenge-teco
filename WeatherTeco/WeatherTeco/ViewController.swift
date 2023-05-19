//
//  ViewController.swift
//  WeatherTeco
//
//  Created by Alan Forneron on 18/05/2023.
//

import UIKit

class ViewController: UIViewController {
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Ingrese una ubicación"
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        searchBar.delegate = self
        searchBar.searchBarStyle = .prominent
    }
    
    private func setupViews() {
        view.addSubview(weatherLabel)
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            weatherLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            weatherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            weatherLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let location = searchBar.text else { return }
        WeatherService.shared.fetchWeather(location) { [weak self] (weatherData) in
            guard let weatherData = weatherData else { return }
            
            DispatchQueue.main.async {
                self?.weatherLabel.text = "Temperatura: \(weatherData.main.temp)°C\nDescripción: \(weatherData.weather[0].description)"
            }
        }
    }
}
