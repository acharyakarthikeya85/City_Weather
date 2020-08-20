//
//  AddCityViewController.swift
//  CityWeather
//
//  Created by K Karthikeya on 19/08/20.
//  Copyright © 2020 K Karthikeya. All rights reserved.
//

import Foundation
import UIKit

protocol AddWeatherDelegate {
    func didAddWeather(weatherVM : WeatherViewModel)
}

class AddCityViewController : UIViewController {
    
    var delegate : AddWeatherDelegate?
    
    @IBOutlet weak var cityName: UITextField!
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addCityToList(_ sender: Any) {
        if let city = self.cityName.text {
            let weatherUrl = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=400ef776a23fd2fefdb2406c7142f3d1&units=imperial")!
            let weatherResource = Resource<WeatherViewModel>(url: weatherUrl){ responseData in
                    let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: responseData)
                    return weatherVM
            }
            
            WeatherWebServices().loadWebServices(resources: weatherResource){ [weak self] result in
                
                if let weatherVM = result {
                    if let delegate = self?.delegate {
                        delegate.didAddWeather(weatherVM: weatherVM)
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
            
        }
    }
    
}
