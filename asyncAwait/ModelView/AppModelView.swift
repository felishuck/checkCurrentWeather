//
//  AppModelView.swift
//  asyncAwait
//
//  Created by Félix Tineo Ortega on 9/6/22.
//

import Foundation

class AppModelView: ObservableObject{
    @Published var cityName: String = ""
    @Published var weatherInformation: WeatherInformation? {
        didSet{
            isResultVisible = weatherInformation == nil ? false : true
        }
    }
    @Published var isResultVisible: Bool = false
    @Published var locationManager: LocationManager = LocationManager()
    
    func buttonWasTapped(){
        if cityName.isEmpty{
            currentLocationInformation()
        } else {
            givenLocationInformation()
        }
        clearCityName()
    }
    
    func currentLocationInformation(){
        locationManager.requestLocation()
        Task { @MainActor in
            if let city = await locationManager.getCityInformation(){
                do{
                weatherInformation = try await WeatherFetcher.fetchWeather(in: city)
                }catch{
                    print("Error getting current weather information")
                }
            }
            
        }
    }
    
    func givenLocationInformation(){
        locationManager.requestLocation()
        Task { @MainActor in
            do {
                    weatherInformation = try await WeatherFetcher.fetchWeather(in: cityName)

            } catch{
                print("error ocurred")
            }
        }
    }
    
    func givenLocationInformation2(){

    }
    
    func clearCityName(){
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { timer in
            self.cityName = ""
            self.weatherInformation = nil
        }

    }
}
