//
//  WeatherVC
//  RainyShinyCloudy
//
//  Created by Fabio Cipriani on 21/08/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    // MARK: @IBOutlets
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var currentWeatherLbl: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Location variables
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts: [Forecast]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.rowHeight = 80
        currentWeather = CurrentWeather()
        forecast = Forecast()
        forecasts = [Forecast]()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
        currentWeather.downloadWeatherDetails {
            self.forecast.downloadForecastData { temp_forecasts in
                self.updateMainUI()
                self.forecasts = temp_forecasts
                self.tableView.reloadData()
            }
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = self.forecasts[indexPath.row]
            cell.configureCell(forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func updateMainUI () {
        dateLbl.text = currentWeather.date
        tempLbl.text = String(format: "%0.1f%°", currentWeather.currentTemp)
        locationLbl.text = "\(currentWeather.cityName), \(currentWeather.country)"
        currentWeatherLbl.text = currentWeather.weatherType
        currentWeatherImg.image = UIImage(named: currentWeather.weatherType)
    }
}
