//
//  Constants.swift
//  s06RainyShinyCloudy
//
//  Created by bernadette on 3/1/17.
//  Copyright © 2017 Bernadette P. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "5723023fa93279c212a57405e2e89f6e"

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)35\(LONGITUDE)139\(APP_ID)\(API_KEY)"
