//
//  WeatherTableViewCell.swift
//  CityWeather
//
//  Created by K Karthikeya on 19/08/20.
//  Copyright © 2020 K Karthikeya. All rights reserved.
//

import Foundation
import UIKit

class WeatherTableViewCell : UITableViewCell {
    
    @IBOutlet weak var cityLabel : UILabel!
    @IBOutlet weak var tempLabel : UILabel!
    
    func configureCell(_ vm: WeatherViewModel){
        self.cityLabel.text = vm.name
        self.tempLabel.text = "\(vm.currentTemp.temperature.formatDouble)"
    }
}
