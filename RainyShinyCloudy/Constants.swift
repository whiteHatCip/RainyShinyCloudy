//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by Fabio Cipriani on 22/08/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/"
let CURRENT_WEATHER_KEYWORD = "weather?"
let FORECAST_KEYWORD = "forecast/daily?"
let FORECAST_SEGUE = "&cnt=10&mode=json"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "79cc7f0387d7a85ef9e74cc13bb4ab13"

typealias DownloadComplete = () -> ()
typealias CompletionHandler = ([Forecast]) -> Void

let CURRENT_WEATHER_URL = "\(BASE_URL)\(CURRENT_WEATHER_KEYWORD)\(LATITUDE)40.83\(LONGITUDE)14.25\(APP_ID)\(API_KEY)"
let FORECAST_URL = "\(BASE_URL)\(FORECAST_KEYWORD)\(LATITUDE)40.83\(LONGITUDE)14.25\(FORECAST_SEGUE)\(APP_ID)\(API_KEY)"
