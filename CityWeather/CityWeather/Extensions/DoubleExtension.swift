//
//  DoubleExtension.swift
//  CityWeather
//
//  Created by K Karthikeya on 20/08/20.
//  Copyright © 2020 K Karthikeya. All rights reserved.
//

import Foundation

extension Double {
    var formatDouble : String {
        return String(format: "%.0f °", self)
    }
}
