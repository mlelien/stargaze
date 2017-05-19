//
//  ViewController.swift
//  Stargaze
//
//  Created by Emily Lien on 1/8/17.
//  Copyright © 2017 EmilyLien. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var timelineTableView: UITableView!

    lazy var allWeather: [(time: String, temperature: Int, icon: UIImage)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        get24HourWeather()
        sunMoonStuff()
        timelineTableView.dataSource = self
        timelineTableView.delegate = self
    }
    
    func allWeatherSize() -> Int {
       return 24 + (sunriseEnabled() ? 1 : 0) + (sunsetEnabled() ? 1 : 0) + (moonriseEnabled() ? 1 : 0) + (moonsetEnabled() ? 1 : 0)
    }
    
    func get24HourWeather() {
        for i in 0...23 {
            let currWeather = currentWeather(hour: i)
            if allWeather.count <= 24 {
                allWeather.append(currWeather)
            } else {
                allWeather[i] = currWeather
            }
            if (i == 0) {
                allWeather[i].time = "Now"
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineHourCell") as! TimelineTableViewCell
        
        cell.hourLabel.text = allWeather[indexPath.row].time
        cell.temperatureLabel.text = String(allWeather[indexPath.row].temperature) + "º"
        cell.iconIV.image = allWeather[indexPath.row].icon
        
        return cell
    }
}



