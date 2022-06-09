//
//  WeatherInformation.swift
//  asyncAwait
//
//  Created by Félix Tineo Ortega on 8/6/22.
//

import Foundation

struct WeatherInformation {
    var name: String
    var id: Int
    var main: TemperatureInformation
    var sys: Information
}

extension WeatherInformation: Decodable{
    
}

extension WeatherInformation: Equatable{
    static func ==(lhs: Self, rhs: Self) -> Bool{
        return lhs.id == rhs.id
    }
}

struct Information: Decodable{
    var country:String
}

struct TemperatureInformation:Decodable{
    var temp:Double
}
