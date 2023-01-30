//
//  DataParsing.swift
//  Weather
//
//  Created by Elsa Netz on 2022-11-24.
//

import Foundation
import UIKit
import Network

class DataParsing: Identifiable {
    var weatherInfos: [TimeSeries] = []
    var weathers: [Weather] = []
    var approvedTime: String = ""
    var coordinates: [Float] = Array(repeating: 0, count: 2)
    var storage = Storage()
    var invalidCoordinates: Bool = false
    
    func load() -> [Weather] {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = {path in
            do {
                if path.status == .satisfied {
                    print("connected")
                    //let urlString = "https://maceo.sth.kth.se/weather/forecast?lonLat=lon/14.333/lat/60.383"
                    let urlString = "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/"+"\(self.coordinates[0])"+"/lat/"+"\(self.coordinates[1])"+"/data.json"
                    if let url = URL(string: urlString) {
                        let task = URLSession.shared.dataTask(with: url) { data,response,error in
                            self.parse(json: data!)
                        }
                        task.resume()
                    }
                } else {
                    self.weathers = self.storage.retrieveWeathers()
                    self.approvedTime = self.storage.retrieveCoordinatesAndApprovedTime().1
                    self.coordinates = self.storage.retrieveCoordinatesAndApprovedTime().0
                    throw URLError(.notConnectedToInternet)
                }
                print(path.isExpensive)
            } catch let err {
                print(err)
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        return storage.retrieveWeathers()
    }
    
    func parse(json: Data) {
        weatherInfos.removeAll()
        let decoder = JSONDecoder()
        if let jsonWeather = try? decoder.decode(JSONModel.self, from: json) {
            storage.saveCoordinatesAndApprovedTime(coordinates: jsonWeather.geometry.coordinates[0], approvedTime: jsonWeather.approvedTime)
            let weatherInfos = jsonWeather.timeSeries
            for parameters in weatherInfos {
                self.weatherInfos.append(parameters)
            }
            self.filterData()
        }
    }
    
    func filterData() {
        weathers.removeAll()
        for w in weatherInfos {
            DispatchQueue.main.async {
                self.weathers.append(Weather(id: self.weathers.count, temperature: w.parameters[10].values, cloudCoverage: w.parameters[6].values, validTime: w.validTime, symbol: w.parameters[18].values))
            }
        }
        storage.saveWeathers(newWeather: self.weathers)
    }
    
    func checkCoordinates(longitude: Float,latitude: Float) {
        do {
            if longitude>(-8.541278) && (longitude<37.848053) && (latitude>52.500440) && (latitude<70.740996) {
                self.changeCoordinates(longitude: longitude, latitude: latitude)
                self.invalidCoordinates = false
            } else {
                throw CoordinateError.invalidCoordinates
            }
        } catch let err {
            self.invalidCoordinates = true
            print(err)
        }
    }
    
    func getStoredWeathers() -> [Weather] {
        return storage.retrieveWeathers()
    }
    
    func getStoredCoordinatesAndApprovedTime() -> ([Float],String) {
        return storage.retrieveCoordinatesAndApprovedTime()
    }
    
    func changeCoordinates(longitude: Float,latitude : Float) {
        self.coordinates[0] = longitude
        self.coordinates[1] = latitude
    }
}

struct Weather: Identifiable, Codable {
    var id: Int
    var temperature: [Float]
    var cloudCoverage: [Float]
    var validTime: String
    var symbol: [Float]
}

struct Storage {
    let defaultWeathers = UserDefaults.standard
    init(){}
    
    func saveWeathers(newWeather: [Weather]) {
        do {
            let encoder = JSONEncoder()
            let newWeathers = try encoder.encode(newWeather)
            defaultWeathers.setValue(newWeathers, forKey: "savedWeathers")
        } catch {
            print("can't save weathers")
        }
    }
    
    func retrieveWeathers() -> [Weather] {
        guard let savedWeathersData = defaultWeathers.object(forKey: "savedWeathers") as? Data else { return [] }
        do {
            let decoder = JSONDecoder()
            let retrievedWeathers = try decoder.decode([Weather].self, from: savedWeathersData)
            return retrievedWeathers
        } catch {
            print("can't retrieve weathers")
            return([])
        }
    }
    
    func saveCoordinatesAndApprovedTime(coordinates: [Float],approvedTime: String) {
        defaultWeathers.setValue(coordinates, forKey: "coordinates")
        defaultWeathers.setValue(approvedTime, forKey: "approvedTime")
    }
    
    func retrieveCoordinatesAndApprovedTime() -> ([Float],String) {
        return (defaultWeathers.object(forKey: ("coordinates")) as! [Float],defaultWeathers.string(forKey: "approvedTime")!)
    }
}

enum CoordinateError: Error {
    case invalidCoordinates
}
