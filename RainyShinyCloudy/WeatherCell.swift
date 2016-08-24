//
//  WeatherCell.swift
//  RainyShinyCloudy
//
//  Created by Fabio Cipriani on 24/08/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var highLbl: UILabel!
    @IBOutlet weak var lowLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ forecast: Forecast) {
        lowLbl.text = String(format: "%0.2f", forecast.lowTemp)
        highLbl.text = String(format: "%0.2f", forecast.highTemp)
        dayLbl.text = forecast.date
        weatherLbl.text = forecast.weatherType
        weatherImg.image = UIImage(named: "\(forecast.weatherType) Mini")
    }
    
}
