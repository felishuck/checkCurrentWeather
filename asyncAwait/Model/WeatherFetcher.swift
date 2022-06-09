//
//  WeatherFetcher.swift
//  asyncAwait
//
//  Created by Félix Tineo Ortega on 8/6/22.
//

import Foundation

class WeatherFetcher {
    
    static let appid = "acf1b985e8b56922d01cd383c0f7f257"
    
    static func fetchWeather(in cityName:String) async throws -> WeatherInformation? {
        let formattedCityName = cityName.replacingOccurrences(of: " ", with: "%20")
        let urlForm = "https://api.openweathermap.org/data/2.5/weather?q=\(formattedCityName)&appid=\(appid)&units=metric"
        
        guard let url = URL(string: urlForm) else {return nil}
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return nil }
        
        return try? JSONDecoder().decode(WeatherInformation.self, from: data)
        
    }
    
    static func fetchWeather(in city:City) async throws -> WeatherInformation? {
        let formattedCityName = city.name.replacingOccurrences(of: " ", with: "%20")
        let urlForm = "https://api.openweathermap.org/data/2.5/weather?q=\(formattedCityName),\(city.countryCode!)&appid=\(appid)&units=metric"
        
        guard let url = URL(string: urlForm) else {return nil}
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return nil }
        
        return try? JSONDecoder().decode(WeatherInformation.self, from: data)
        
    }
    
    static func fetchWeather(at location:Location) async throws -> WeatherInformation?{
        let urlForm = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.lat)&lon=\(location.lon)&appid=\(appid)&units=metric"
        guard let url = URL(string: urlForm) else {return nil}
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return nil }
        
        return try? JSONDecoder().decode(WeatherInformation.self, from: data)
    }
    
}
