//
//  Forecast.swift
//  s06RainyShinyCloudy
//
//  Created by bernadette on 3/7/17.
//  Copyright © 2017 Bernadette P. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    // data encapsulation
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    // if empty or nil, instantiate to an empty string
    var date: String {
        
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    // Create initializer that will pull the data that we downloaded into our Forecast class, and that will run it through and set all the values, so that we can set it in our UI
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        // in API - an array called "list", which has dictionaries inside it. 
        
        
        // Get LOW & HIGH TEMP ~~
        // 'weatherDict' is our outermost dictionary called "list"
        
        // inside of our weatherDict, pass in dictionary called "temp"
        // cast as Dictionary of String / AnyObject
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            // inside of the "temp" dictionary are keys & values - see keys "min" & "max" for low/high temps
            // in the API, min & max are of type Double -- so cast as Double
            if let min = temp["min"] as? Double {
                
                // copy in Kelvin conversion from CurrentWeather file
                let kelToCelPreDivision = (min - 273.15)
                
                let kelvinToCelsius = Double(round(10 * kelToCelPreDivision/10))
                
                // change kelvinToCelsius into a string using String Interpolation
                self._lowTemp = "\(kelvinToCelsius)"
            }
            
            if let max = temp["max"] as? Double {
                
                let kelToCelPreDivision = (max - 273.15)

                let kelvinToCelsius = Double(round(10 * kelToCelPreDivision/10))
                
                self._highTemp = "\(kelvinToCelsius)"
                
            }
            
        }
        
        // Get WEATHER TYPE ~~
        // 'weatherDict' is our outermost dictionary called "list"
        
        // in the API, what we want as 'weather' is 'main' - which is in a Dictionary within an array, within "weather"
        // '= search through the dict, find key called "weather" - cast as an array of Dictionary, with the key being String, and value being AnyObject'
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            // pull value 'main'
            // need to get correct index for "weather" in API - an array of Dictionaries
            // since there is only one Dictionary in that array, index is 0 (first) - inside the first Dictionary, we pull out the key value for 'main' - cast as a String (since in the API, the value is a string... "main":"Clouds")
            if let main = weather[0]["main"] as? String {
                
                self._weatherType = main.capitalized
            }
        }
        
        // Get DATE ~~
        // 'weatherDict' is our outermost dictionary called "list"
        // Need to write an extension of Date (formerly 'NSDate') - below
        
        if let date = weatherDict["dt"] as? Double {

            // in the API, the date/timestamp is in Unix Timestamp format - need to convert
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none     // we don't want the time
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
    
    
}

// extensions need to be outside of the class (end bracket)
extension Date {
    
    func dayOfTheWeek() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"   // EEEE - full name of day of the week
        
        return dateFormatter.string(from: self)
    }
}
