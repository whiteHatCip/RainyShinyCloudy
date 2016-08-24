//
//  Forecast.swift
//  RainyShinyCloudy
//
//  Created by Fabio Cipriani on 23/08/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import UIKit
import Alamofire

class Forecast { // Class begins
    
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: Double!
    private var _lowTemp: Double!
    
    init() {
        _date = ""
        _weatherType = ""
        _highTemp = 0.0
        _lowTemp = 0.0
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let high = temp["max"] as? Double {
                let celsiusTemp = high - 273.15
                self.highTemp = celsiusTemp
            }
            if let low = temp["min"] as? Double {
                let celsiusTemp = low - 273.15
                self.lowTemp = celsiusTemp
            }
        } // End if
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                weatherType = main
            }
        } // End if
        
        if let data = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: data)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self.date = unixConvertedDate.DayOfTheWeek()
        } // End if
        
        
    } // init with parameter ends
    
    //Setters and getters begin
    var date: String {
        get {
            return _date
        } set {
            _date = newValue
        }
    }
    
    var weatherType: String {
        get {
            return _weatherType
        } set {
            _weatherType = newValue
        }
    }
    
    var highTemp: Double {
        get {
            return _highTemp
        } set {
            _highTemp = newValue
        }
    }
    
    var lowTemp: Double {
        get {
            return _lowTemp
        } set {
            _lowTemp = newValue
        }
    }
    // Setters and getters end
    
    func downloadForecastData(completed: CompletionHandler) {
        let forecastURL = URL(string: FORECAST_URL)!
        var forecasts = [Forecast]()
        Alamofire.request(forecastURL, withMethod: .get).responseJSON {
            Response in let result = Response.result
            print(result)
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String,AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        forecasts.append(forecast)
                    }
                    forecasts.remove(at: 0)
                }
            }
            completed(forecasts)
        }
    }
    
} // End of the class

// Extension to the Date class for getting just the day of the week out of a date 
extension Date {
    func DayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
