//
//  WeatherRow.swift
//  Weather
//
//  Created by Elsa Netz on 2022-11-23.
//

import SwiftUI

struct WeatherRow: View {
    var weather: Weather
    @EnvironmentObject var theController : Controller
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(weather.validTime)")
            HStack {
                switch Int(weather.symbol[0]) {
                case 1:
                    Image("1")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 2:
                    Image("2")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 3:
                    Image("3")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 4:
                    Image("4")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 5:
                    Image("5")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 6:
                    Image("6")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 7:
                    Image("7")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 8:
                    Image("8")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 9:
                    Image("9")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 10:
                    Image("10")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 11:
                    Image("11")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 12:
                    Image("12")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 13:
                    Image("13")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 14:
                    Image("14")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 15:
                    Image("15")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 16:
                    Image("16")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 17:
                    Image("17")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 18:
                    Image("18")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 19:
                    Image("19")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 20:
                    Image("20")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 21:
                    Image("21")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 22:
                    Image("22")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 23:
                    Image("23")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 24:
                    Image("24")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 25:
                    Image("25")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 26:
                    Image("26")
                        .resizable()
                        .frame(width: 70,height: 50)
                case 27:
                    Image("27")
                        .resizable()
                        .frame(width: 70,height: 50)
                default:
                    Text("\(Int(weather.cloudCoverage[0]))")
                }
                VStack {
                    Text("\(Int(weather.temperature[0])) °C")
                    Text("Cloud coverage: \(Int(weather.cloudCoverage[0])) octas")
                }
            }
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherRow(weather: Weather(id: 1, temperature: [1], cloudCoverage: [1], validTime: "", symbol: [0])).environmentObject(Controller())
        }
    }
}
