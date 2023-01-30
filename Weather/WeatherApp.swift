//
//  WeatherApp.swift
//  Weather
//
//  Created by Elsa Netz on 2022-11-23.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject private var theController = Controller()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Controller())
        }
    }
}
