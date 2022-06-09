//
//  Location.swift
//  asyncAwait
//
//  Created by Félix Tineo Ortega on 9/6/22.
//

import Foundation

struct Location: CustomStringConvertible {
    let lon:Double
    let lat:Double
    var description: String{
        return "Lat: \(lat), Lon: \(lon)"
    }
}
