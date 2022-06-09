//
//  City.swift
//  asyncAwait
//
//  Created by Félix Tineo Ortega on 9/6/22.
//

import Foundation
import CoreLocation

struct City {
    var name: String
    var country: String
    var countryCode: String?
    var lon: CLLocationDegrees
    var lat: CLLocationDegrees
}
