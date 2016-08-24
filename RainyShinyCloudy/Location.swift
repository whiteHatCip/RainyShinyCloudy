//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by Fabio Cipriani on 24/08/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
