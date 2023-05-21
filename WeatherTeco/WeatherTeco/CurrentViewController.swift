//
//  ViewController.swift
//  WeatherTeco
//
//  Created by Alan Forneron on 18/05/2023.
//

import UIKit
import CoreLocation

class CurrentViewController: UIViewController {
    private var tableView = UITableView()
    private let locationManager = LocationManager()
    
    let data = String.cities.sorted()

    var filteredData: [String]!
    
    private lazy var extendedButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.setTitle(String.buttonTitle, for: .normal)
        return button
    }()

    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "..."
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = String.searchTitle
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpView()
    }
    
    @objc func searchButtonTapped(_ sender: UIButton) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        searchCoordinates(searchText: searchText)
    }

    func searchCoordinates(searchText: String) {
        locationManager.geocodeAddress(searchText) { [weak self] result in
                    switch result {
                    case .success(let placemark):
                        guard let coordinates = placemark.location?.coordinate else {
                            return
                        }
                        self?.fetchWeatherForCoordinates(coordinates, cityName: searchText)
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
    }
    
    private func fetchWeatherForCoordinates(_ coordinates: CLLocationCoordinate2D, cityName: String) {
        WeatherService.shared.fetchWeather30(latitude: coordinates.latitude, longitude: coordinates.longitude) { [weak self] result in
            switch result {
            case .success(let weatherData):
                DispatchQueue.main.async {
                    self?.showForecastViewController(weatherData: weatherData, cityName: cityName)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    private func showForecastViewController(weatherData: WeatherData, cityName: String) {
        let forecastViewController = ForecastViewController()
        
        forecastViewController.weatherData = weatherData
        forecastViewController.cityName = cityName
        
        navigationController?.pushViewController(forecastViewController, animated: true)
    }
    
    private func setUpView() {
        buildViewHierarchy()
        setUpConstraints()
        setUpAdditionalConfigs()
    }
    
    private func setUpAdditionalConfigs() {
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: String.cellName)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        filteredData = data
        navigationItem.title = String.navTitle
    }
    
    private func buildViewHierarchy() {
        [weatherLabel, searchBar, tableView, extendedButton].forEach{view.addSubview($0)}
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            weatherLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            weatherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            weatherLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: weatherLabel.topAnchor, constant: -16),

            extendedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            extendedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            extendedButton.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 26)
        ])
    }
}

extension CurrentViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let location = searchBar.text else { return }
        WeatherService.shared.fetchWeather(location) { [weak self] (weatherData) in
            guard let weatherData = weatherData else { return }
            
            DispatchQueue.main.async {
                self?.weatherLabel.text = "Temperatura: \(weatherData.main.temp)°C\n \(weatherData.weather[0].description)"
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
}

extension CurrentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.cellName, for: indexPath) as! CityTableViewCell
        cell.cityLabel.text = filteredData[indexPath.row]
        return cell
    }


}

extension CurrentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = filteredData[indexPath.row]
        searchBar.text = selectedCity
    }

}

fileprivate extension String {
    static let navTitle = "Bienvenidos a Clima"
    static let cellName = "CityCell"
    static let searchTitle = "Ingrese una ubicación"
    static let buttonTitle = "Mostrar pronóstico extendido"
    static let cities = ["La Plata", "San Fernando del Valle de Catamarca", "Resistencia", "Rawson",
                                   "Corrientes", "Córdoba", "Paraná", "Formosa",
                                   "San Salvador de Jujuy", "Santa Rosa", "La Rioja", "Mendoza",
                                   "Posadas", "Neuquén", "Viedma", "Salta",
                                   "San Juan", "San Luis", "Río Gallegos", "Santiago del Estero", "Ushuaia", "Santa Fe", "San Miguel de Tucumán"]
}
