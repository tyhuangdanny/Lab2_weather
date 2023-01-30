//
//  WeatherView.swift
//  Weather
//
//  Created by Elsa Netz on 2022-11-30.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var theController : Controller
    
    var body: some View {
        VStack {
            Text("Approved time: \(theController.getCoordinatesAndApprovedTime().1)")
            Text("\(theController.getCoordinatesAndApprovedTime().0[0]), \(theController.getCoordinatesAndApprovedTime().0[1])")
            List {
                ForEach(theController.getWeathers()) { weather in
                    WeatherRow(weather: weather)
                }
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView().environmentObject(Controller())
    }
}
