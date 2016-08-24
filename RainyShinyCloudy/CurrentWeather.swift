//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by Fabio Cipriani on 22/08/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    private var _cityName: String!
    private var _country: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    init() {
        _weatherType = ""
        _cityName = ""
        _country = ""
        _currentTemp = 0.0
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        _date = "Oggi, \(currentDate)"
    }
    
    var cityName: String {
        get {
            return _cityName
        } set {
            _cityName = newValue
        }
    }
    
    var country: String {
        get {
            return _country
        } set {
            _country = newValue
        }
    }
    
    var weatherType: String {
        get {
            return _weatherType
        } set {
            _weatherType = newValue
        }
    }
    var currentTemp: Double {
        get {
            return _currentTemp
        } set {
            _currentTemp = newValue
        }
    }
    
    var date: String {
        get {
            return _date
        }
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        // Alamofire download
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        
        Alamofire.request(currentWeatherURL, withMethod: .get).responseJSON { Response in
            let result = Response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self.cityName = name.capitalized
                }
                if let sys = dict["sys"] as? Dictionary<String, AnyObject> {
                    if let country = sys["country"] as? String {
                        self.country = country
                    }
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self.weatherType = main.capitalized
                    }
                }
                if let main = dict["main"] as? Dictionary<String, Double> {
                    if let temp = main["temp"] {
                        let celsiusTemperature = temp - 273.15
                        self.currentTemp = celsiusTemperature
                    }
                }
            }
            completed()
        }
    }
}
