//
//  WeatherCell.swift
//  s06RainyShinyCloudy
//
//  Created by bernadette on 3/8/17.
//  Copyright © 2017 Bernadette P. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell(forecast: Forecast) {
        
        // set up outlets to pull data from an instance of Forecast
        
        // remember our temps are returned as Double, so use string interpolation (to insert in label as text)
        lowTemp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        // we set all the string values to equal the string value of 'weatherType' -- the name of the weather type is the name of the image file
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }




}
