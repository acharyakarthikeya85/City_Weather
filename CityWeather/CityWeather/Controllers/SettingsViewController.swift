//
//  SettingsViewController.swift
//  CityWeather
//
//  Created by K Karthikeya on 20/08/20.
//  Copyright © 2020 K Karthikeya. All rights reserved.
//

import Foundation
import UIKit

protocol SettingProtocol {
    func settingsDone(vm: SettingsViewModel)
}

class SettingsViewController : UITableViewController {
    var settingsVM = SettingsViewModel()
    var delegate : SettingProtocol?
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.settingsVM.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        let settingUnit = self.settingsVM.units[indexPath.row]
        cell.textLabel?.text = settingUnit.displayName
        
        if  settingUnit == self.settingsVM.selectedItem{
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Deselect all visible cells before any selection
        tableView.visibleCells.forEach { (cell) in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath){
            cell.accessoryType = .checkmark
            let unit = Units.allCases[indexPath.row]
            self.settingsVM.selectedItem = unit
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            cell.accessoryType = .none
        }
    }
    
    @IBAction func donePressed(_ sender: Any) {
        if let delegate = self.delegate{
            delegate.settingsDone(vm:self.settingsVM)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
