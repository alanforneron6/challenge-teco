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
        label.font = UIFont.boldSystemFont(ofSize: CGFloat.lblSize)
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
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.leading),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.trailing),
            cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.top),
            cityLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: CGFloat.bottom)
        ])
    }
}

fileprivate extension CGFloat {
    static let leading = 16 as CGFloat
    static let trailing = -16 as CGFloat
    static let top = 8 as CGFloat
    static let bottom = -8 as CGFloat
    static let lblSize = 16 as CGFloat
}
