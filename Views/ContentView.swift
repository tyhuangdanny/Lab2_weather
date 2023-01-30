//
//  ContentView.swift
//  Weather
//
//  Created by Elsa Netz on 2022-11-23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var theController : Controller
    @State var longitude: Float = 0.0
    @State var latitude: Float = 0.0
    @State var invalidCoordinates = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Weather forecast")
                Divider()
                Spacer()
                Text("Longitude: -8.541278 to 37.848053")
                Text("Latitude: 52.500440 to 70.740996")
                Spacer()
                HStack {
                    Text("Longitude:")
                    TextField("Longitude",value: $longitude,format: .number,prompt: Text("Longitude"))
                        .textFieldStyle(.roundedBorder)
                    Text("Latitude:")
                    TextField("Latitude",value: $latitude,format: .number,prompt: Text("Latitude"))
                        .textFieldStyle(.roundedBorder)
                }
                HStack {
                    Button {
                        theController.checkCoordinates(newLongitude: longitude, newLatitude: latitude)
                        theController.parseData()
                        invalidCoordinates = theController.coordinatesCheck()
                    } label: {
                        Text("Submit")
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .alert(isPresented: $invalidCoordinates) {
                        Alert(title: Text("Invalid coordinates"))
                
                    }
                    NavigationLink("View weather", destination: WeatherView())
                        .onAppear(perform: theController.parseData)
                }
            }
            .padding()
        }
        .onAppear(perform: theController.startApp)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Controller())
    }
}
