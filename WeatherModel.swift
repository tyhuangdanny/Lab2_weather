//
//  WeatherModel.swift
//  Weather
//
//  Created by Elsa Netz on 2022-11-26.
//

import Foundation

struct WeatherModel {
    var weathers: [Weather] = []
    private var longitude: Float = 0.0
    private var latitude: Float = 0.0
    
    mutating func parseData(weathers: [Weather]) {
        self.weathers = weathers
    }
    
    mutating func changeCoordinates(longitude: Float,latitude: Float) {
        self.longitude = longitude
        self.latitude = latitude
    }
}
