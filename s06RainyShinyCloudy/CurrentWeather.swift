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
    var _weatherIcon: String!
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
    
    var weatherIcon: String {
        
        if _weatherIcon == nil {
            _weatherIcon = ""
        }
        return _weatherIcon
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        
        // initialize the url to tell Alamofire where to download from
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!   // force unwrap to prove it will be there
        
        Alamofire.request(currentWeatherURL).responseJSON { response in
            
            let result = response.result    // every request has a response, & every response has a result
//            print(result)
            
            // if let dict = value within 'result' cast as (conditionally) a Dictionary of String (keys), with values as AnyObject
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                // looking at the API's keys - find needed keys
                // '= search through the dict, find key called "name", & pass the value in as a String'
                if let name = dict["name"] as? String {
                    
                    self._cityName = name.capitalized       // just capitalizing first letter
                    print(self._cityName)      // we're inside of a closure, so need "self."
                }
                
                // Get WEATHER TYPE ~~
                // in the API, what we want as 'weather' is 'main' - which is in a Dictionary within an array, within "weather"
                // '= search through the dict, find key called "weather" - cast as an array of Dictionary, with the key being String, and value being AnyObject'
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    // pull value 'main'
                    // need to get correct index for "weather" in API - an array of Dictionaries
                    // since there is only one Dictionary in that array, index is 0 (first) - inside the first Dictionary, we pull out the key value for 'main' - cast as a String (since in the API, the value is a string... "main":"Rain")
                    if let main = weather[0]["main"] as? String {
                        
                        // set value of _weatherType
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
                
                // Get CURRENT TEMP ~~
                // in the API, what we want is 'temp' - which is in a Dictionary called "main" (note: not within an array, such as in weather type)
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    // the value we want is from the key "temp"
                    // '= from main (our dict), pull out the value 'temp' and cast is as a Double' (since in the API, the value is a Double... "temp":296.12)
                    if let currentTemperature = main["temp"] as? Double {
                        
                        // API is showing temp in Kelvin, so need to convert
                        let kelToCelPreDivision = (currentTemperature - 273.15)
                        
                        let kelvinToCelsius = Double(round(10 * kelToCelPreDivision/10))
                        
                        self._currentTemp = kelvinToCelsius
                        print(self._currentTemp)
                    }
                }
                
                // Get WEATHER ICON ~~
                if let wIcon = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let icon = wIcon[0]["icon"] as? String {
                        
                        self._weatherIcon = icon
                        print(self._weatherIcon)
                    }
                }
                
            }
        	completed()
            
        }

    }
    
}

