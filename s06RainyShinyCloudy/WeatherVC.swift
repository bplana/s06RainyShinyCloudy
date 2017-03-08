//
//  WeatherVC.swift
//  s06RainyShinyCloudy
//
//  Created by bernadette on 2/28/17.
//  Copyright © 2017 Bernadette P. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather = CurrentWeather()   // create a generic class / instance of CurrentWeather
    var forecast: Forecast!
    var forecasts = [Forecast]()       // for func downloadForecastData
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set delegate & dataSource
        tableView.delegate = self
        tableView.dataSource = self
        
//        print(CURRENT_WEATHER_URL)
        
        currentWeather = CurrentWeather()
//        forecast = Forecast()       // instatiate an empty Forecast class
        
        currentWeather.downloadWeatherDetails {
            
            self.downloadForecastData {
              self.updateMainUI()
            }
            
        }
    
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        
        // download forecast weather data for TableView
        let forecastURL = URL(string: FORECAST_URL)!
        
        Alamofire.request(forecastURL).responseJSON { response in   //whatever response we get in JSON
            
            //... we want to capture its result (raw data)
            let result = response.result
            
            //... whatever value of 'result' is, pass in as a Dictionary of String / AnyObject
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                // API - inside the dictionary, there is an array of dictionaries called "list", and those dictionaries are of String / AnyObject
                
                // We are creating a dictionary, that everytime we parse through & find a dictionary in our array, it will run this loop (below), and we will pass in that dictionary ("obj") into another dictionary ("weatherDict")
                // So, for every forecast/dictionary we find within API's "list", we are adding it to another dictionary elsewhere (need to create an array where this is going to go into)
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    // pull out min & max temp for week's forecast (individually)
                    // for loop
                    // "for every object in our array called list"
                    for obj in list {
                        
                        // ... instantiate Forecast called forecast
                        // ... we pass in our obj, but put it into 'weatherDict'
                        
                        let forecast = Forecast(weatherDict: obj)   // initialize 'weatherDict' in Forecast
                        self.forecasts.append(forecast)     // adding each forcast into our array 'forecasts'
                        
                        print(obj)
                    }
                    
                    // remove 1st indexPath from 'forecasts' array, since that is today's forecast
                    self.forecasts.remove(at: 0)
                    
                    // reload data
                    self.tableView.reloadData()
                    
                }
                
            }
            // after the response (from let result = response.result)
            completed()
            
        }
    }

    // tableView delegate funcs:
    // (1)  numberOfSections in tableView
    // (2)  numberOfRowsInSection (how many cells do you want in the tableView)
    // (3)  cellForRowAt indexPath
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count        // set # of rows to equal the # of items in our forecasts array (10)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // need to create a cell (dequeueReusableCell (withIdentifier.. for..))
        // -- also need to give storyboard's Table View Cell an identifier, for "withIdentifier" string (below)
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            // which forecast to pass in, at which time
            // pull out one 'forecast' from 'forecasts'(array) -- for each cell that is created, it gets an indexPath
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
            
        } else {        //at least return a blank tableView cell, so app does not crash
            
            return WeatherCell()
        }
        
    }
    
    func updateMainUI() {
        
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)°"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherIcon)
    }

}

