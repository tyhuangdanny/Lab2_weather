//
//  JSONModel.swift
//  Weather
//
//  Created by Elsa Netz on 2022-11-25.
//

import Foundation

struct JSONModel: Codable {
    let timeSeries: [TimeSeries]
    let approvedTime: String
    let geometry: Geometry
}

struct TimeSeries: Codable {
    let validTime: String
    let parameters: [WeatherInfo]
}

struct WeatherInfo: Codable {
    let name: String
    let levelType: String
    let level: Int
    let unit: String
    let values: [Float]
}

struct Geometry: Codable {
    let type: String
    let coordinates: [[Float]]
}
