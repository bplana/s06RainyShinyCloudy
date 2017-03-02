//
//  CurrentWeather.swift
//  s06RainyShinyCloudy
//
//  Created by bernadette on 3/1/17.
//  Copyright © 2017 Bernadette P. All rights reserved.
//

import UIKit    // remove Foundation & import UIKit instead
import Alamofire    // import Alamofire

class CurrentWeather {
    
    // Data hiding/encapsulation - limits who can access these variables
    // so that only our download func can access these vars, and only in this file
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    // for later:  highTemp, lowTemp
    
    var cityName: String {
        
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    // Need to use dateFormatter for the date
    var date: String {
        
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()       // create an instance of DateFormatter (named dateFormatter)
        dateFormatter.dateStyle = .long         // create a dateStyle & timeStyle
        dateFormatter.timeStyle = .none         // don't want the time to be in the date string
        let currentDate = dateFormatter.string(from: Date())    // 'create a string of the current date'
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        
        if _currentTemp == nil {
            _currentTemp = 0.0      //because this is a Double
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        
        // initialize the url to tell Alamofire where to download from
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!   // force unwrap to prove it will be there
        
        Alamofire.request(currentWeatherURL).responseJSON { response in
            
            let result = response.result    // every request has a response, & every response has a result
            print(result)
        }
        completed()
    }
    
}

