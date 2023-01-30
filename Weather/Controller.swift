//
//  Controller.swift
//  Weather
//
//  Created by Elsa Netz on 2022-11-24.
//

import Foundation

class Controller : ObservableObject {
    private var dataParsing = DataParsing()
    private var theModel = WeatherModel()
    
    func parseData() {
        theModel.parseData(weathers: dataParsing.load())
    }
    
    func setCoordinates(longitude: Float,latitude: Float) {
        dataParsing.changeCoordinates(longitude: longitude, latitude: latitude)
        theModel.changeCoordinates(longitude: longitude, latitude: latitude)
    }
    
    func startApp() {
        theModel.weathers = dataParsing.getStoredWeathers()
        dataParsing.weathers = dataParsing.getStoredWeathers()
        //dataParsing.approvedTime = dataParsing.getStoredCoordinatesAndApprovedTime().1
        //dataParsing.coordinates = dataParsing.getStoredCoordinatesAndApprovedTime().0
    }
    
    func checkCoordinates(newLongitude: Float,newLatitude: Float) {
        dataParsing.checkCoordinates(longitude: newLongitude, latitude: newLatitude)
        theModel.changeCoordinates(longitude: dataParsing.coordinates[0], latitude: dataParsing.coordinates[1])
    }
    
    func getWeathers() -> [Weather] {
        return dataParsing.getStoredWeathers()
    }
    
    func getCoordinatesAndApprovedTime() -> ([Float],String) {
        return dataParsing.getStoredCoordinatesAndApprovedTime()
    }
    
    func coordinatesCheck() -> Bool {
        return dataParsing.invalidCoordinates
    }
}
