//
//  Constants.swift
//  s06RainyShinyCloudy
//
//  Created by bernadette on 3/1/17.
//  Copyright © 2017 Bernadette P. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5"
let WEATHER = "/weather?"

let DAILY_FORECAST = "/forecast/daily?"

let LATITUDE = "lat="
let LONGITUDE = "&lon="

let DAILY_FORE_COUNT = "&cnt=10"

let APP_ID = "&appid="
let API_KEY = "5723023fa93279c212a57405e2e89f6e"

// for downloadWeatherDetails func (CurrentWeather file)
// going to tell the func when we are finished downloading
typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(WEATHER)\(LATITUDE)37\(LONGITUDE)-119\(APP_ID)\(API_KEY)"
let FORECAST_URL = "\(BASE_URL)\(DAILY_FORECAST)\(LATITUDE)37\(LONGITUDE)-119\(DAILY_FORE_COUNT)\(APP_ID)\(API_KEY)"





