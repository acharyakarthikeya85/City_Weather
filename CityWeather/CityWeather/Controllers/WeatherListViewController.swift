//
//  WeatherListViewController.swift
//  CityWeather
//
//  Created by K Karthikeya on 19/08/20.
//  Copyright © 2020 K Karthikeya. All rights reserved.
//

import Foundation
import UIKit

class WeatherListViewController : UITableViewController, AddWeatherDelegate {
    
    var weatherListVM = WeatherListViewModel()
    private var lastUnitSelection :Units!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: "unit") as? String {
            self.lastUnitSelection = Units(rawValue: value)!
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherListVM.numberOfRowsInTable(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherTableViewCell
        let weatherCity = self.weatherListVM.cityAtIndex(indexPath.row)
        cell.configureCell(weatherCity)
        return cell
    }
    
    func didAddWeather(weatherVM: WeatherViewModel) {
        print(weatherVM.name)
        self.weatherListVM.addCityToTableView(weatherVM)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addCity" {
            addCityPressed(segue: segue)
        } else if segue.identifier == "settings" {
            settingsPressed(segue: segue)
        }
    }
    
    private func addCityPressed(segue: UIStoryboardSegue){
        guard let navCtrl = segue.destination as? UINavigationController else {
            fatalError("Navigation controller not found")
        }
        guard let addCityController = navCtrl.viewControllers.first as? AddCityViewController else {
            fatalError("No proper view controller found")
        }
        
        addCityController.delegate = self
    }
    
    private func settingsPressed(segue: UIStoryboardSegue){
        guard let navCtrl = segue.destination as? UINavigationController else {
            fatalError("Navigation controller not found")
        }
        guard let settingsController = navCtrl.viewControllers.first as? SettingsViewController else {
            fatalError("No proper view controller found")
        }
        
        settingsController.delegate = self
    }
}

extension WeatherListViewController : SettingProtocol {
    
    func settingsDone(vm: SettingsViewModel) {
        print("Done setting ")
        if self.lastUnitSelection.rawValue != vm.selectedItem.rawValue {
            self.weatherListVM.updateUnit(to: vm.selectedItem)
            self.tableView.reloadData()
            self.lastUnitSelection = Units(rawValue: vm.selectedItem.rawValue)!
        }
    }
    
}
