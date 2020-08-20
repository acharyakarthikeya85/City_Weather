//
//  WeatherListViewModel.swift
//  CityWeather
//
//  Created by K Karthikeya on 19/08/20.
//  Copyright © 2020 K Karthikeya. All rights reserved.
//

import Foundation

//For list of cities
struct WeatherListViewModel {
    private var weatherModels = [WeatherViewModel]()
    
    mutating func addCityToTableView(_ vm : WeatherViewModel){
        self.weatherModels.append(vm)
    }
    
    func numberOfRowsInTable(_ section : Int) -> Int{
        return self.weatherModels.count
    }
    
    func cityAtIndex(_ index:Int) -> WeatherViewModel{
        return self.weatherModels[index]
    }
    
    mutating func updateUnit(to unit : Units){
        switch unit {
        case .celsius:
            self.toCelsius()
        
        case .fahrenheit:
            self.toFahrenheit()
        }
    }
    
    mutating private func toCelsius(){
        //map function is used to iterate through all items in the array. vm is the individual array item
        self.weatherModels = self.weatherModels.map { vm in
            var weatherModel = vm
            weatherModel.currentTemp.temperature = (weatherModel.currentTemp.temperature - 32) * 5/9
            return weatherModel
        }
    }
    
    
    mutating private func toFahrenheit(){
        self.weatherModels = self.weatherModels.map { vm in
                  var weatherModel = vm
                  weatherModel.currentTemp.temperature = (weatherModel.currentTemp.temperature * 9/5) + 32
                  return weatherModel
              }
    }
}

//For individual city
struct WeatherViewModel: Decodable {
    let name : String
    var currentTemp : TemperatureViewModel
    
    private enum CodingKeys: String, CodingKey{
        case name
        case currentTemp = "main"
    }
}

struct TemperatureViewModel : Decodable{
    var temperature : Double
    let temperatureMin : Double
    let temperatureMax : Double
    
    private enum CodingKeys : String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
    // shift + option + 8 gives degree sign
}
