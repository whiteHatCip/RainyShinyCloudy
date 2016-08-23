//
//  WeatherVC
//  RainyShinyCloudy
//
//  Created by Fabio Cipriani on 21/08/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: @IBOutlets
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var currentWeatherLbl: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        currentWeather = CurrentWeather()
    }
    override func viewDidAppear(_ animated: Bool) {
        forecast = Forecast()
        //var forecasts = [Forecast]()
        currentWeather.downloadWeatherDetails {
            self.forecast.downloadForecastData { forecasts in
                self.updateMainUI()
                print("NUMERO ELEMENTI: \(forecasts.count)")
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        return cell
    }
    
    func updateMainUI () {
        dateLbl.text = currentWeather.date
        tempLbl.text = "\(currentWeather.currentTemp)°"
        locationLbl.text = "\(currentWeather.cityName), \(currentWeather.country)"
        currentWeatherLbl.text = currentWeather.weatherType
        currentWeatherImg.image = UIImage(named: currentWeather.weatherType)
    }
}
