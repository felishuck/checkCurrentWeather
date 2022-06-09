//
//  LocationManager.swift
//  asyncAwait
//
//  Created by Félix Tineo Ortega on 8/6/22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    let manager = CLLocationManager()
    @Published var currentLocation: CLLocationCoordinate2D?
    
    override init(){
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first?.coordinate
        
    }
    
    func requestLocation(){
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func getCityInformation() async -> City?{
        var city: City?
        if let currentLocation = currentLocation {
            let geocoder = CLGeocoder()
            do {
                let placemarks = try await geocoder.reverseGeocodeLocation(CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude))
                if let currentPlacemark = placemarks.last, let cityName = currentPlacemark.locality, let country = currentPlacemark.country, let countryCode = currentPlacemark.isoCountryCode{
                    city = City(name: cityName.folding(options: .diacriticInsensitive, locale: .current), country: country, countryCode: countryCode, lon: currentLocation.longitude, lat: currentLocation.latitude)
                }
            } catch {
                print("Error occurred while getting the address")
            }
        }
        return city
    }
}
