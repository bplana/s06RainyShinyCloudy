//
//  WeatherVC.swift
//  s06RainyShinyCloudy
//
//  Created by bernadette on 2/28/17.
//  Copyright © 2017 Bernadette P. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather = CurrentWeather()   // create a generic class of CurrentWeather
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set delegate & dataSource
        tableView.delegate = self
        tableView.dataSource = self
        
//        print(CURRENT_WEATHER_URL)
        
        currentWeather.downloadWeatherDetails {
            
            // Setup UI to load downloaded data
            
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
        return 6        // for the rest of the days of the week
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // need to create a cell (dequeueReusableCell (withIdentifier.. for..))
        // -- also need to give storyboard's Table View Cell an identifier, for "withIdentifier" string (below)
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        
        return cell
    }

}

