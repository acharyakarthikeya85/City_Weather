//
//  SettingsViewModel.swift
//  CityWeather
//
//  Created by K Karthikeya on 20/08/20.
//  Copyright © 2020 K Karthikeya. All rights reserved.
//

import Foundation

struct SettingsViewModel {
    var units = Units.allCases
    private var _selectedUnit : Units = Units.fahrenheit
    var selectedItem : Units {
        get{
            let userDefaults = UserDefaults.standard
            if let value = userDefaults.value(forKey: "unit") as? String{
                return Units(rawValue: value)!
            }
            
            return _selectedUnit
        }
        
        set{
            let userDefaults = UserDefaults.standard
            userDefaults.set(newValue.rawValue, forKey: "unit")
        }
    }
}

enum Units : String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Units {
    var displayName : String {
        get {
            switch self {
            case .celsius:
                return "Celsius"
            default:
                return "Fahrenheit"
            }
        }
    }
}
