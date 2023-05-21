//
//  ForecastViewController.swift
//  WeatherTeco
//
//  Created by Alan Forneron on 20/05/2023.
//

import UIKit

class ForecastViewController: UIViewController {
    var weatherData: WeatherData?
    var cityName: String?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = cityName
        
        // Configurar la tabla
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let dailyData = weatherData?.daily[indexPath.row] else {
            return cell
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let date = Date(timeIntervalSince1970: TimeInterval(dailyData.dt))
        let formattedDate = dateFormatter.string(from: date)

        let minTemp = dailyData.temp.min.rounded()
        let maxTemp = dailyData.temp.max.rounded()

        cell.textLabel?.text = "\(formattedDate) - Min: \(minTemp)°C Max: \(maxTemp)°C"
        return cell
    }
}
