//
//  WeatherTableViewCell.swift
//  WeatherTeco
//
//  Created by Alan Forneron on 20/05/2023.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    func setUpView() {
        buildViewHierarchy()
        setUpConstraints()
    }

    func buildViewHierarchy() {
        addSubview(cityLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cityLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
