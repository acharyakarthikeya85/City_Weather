//
//  WeatherWebServices.swift
//  CityWeather
//
//  Created by K Karthikeya on 19/08/20.
//  Copyright © 2020 K Karthikeya. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url : URL
    let parse : (Data) -> T?
}

class WeatherWebServices {
    func loadWebServices<T>(resources : Resource<T>, completion : @escaping(T?) -> ()) {
        URLSession.shared.dataTask(with: resources.url) { (data, response, error) in
            
            print(data)
            if let data = data{
                DispatchQueue.main.async {
                    completion(resources.parse(data))
                }
            } else {
                  completion(nil)
            }
        }.resume()
    }
}
