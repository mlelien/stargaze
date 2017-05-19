//
//  Network.swift
//  Stargaze
//
//  Created by Emily Lien on 1/8/17.
//  Copyright © 2017 EmilyLien. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

public func darkskyAPI() -> String {
    return "https://api.darksky.net/forecast/9cf8ba9e8ac556384be1c500ffdeb3d9/42.4534531,-76.4756914"
}

public func ssAPI() -> String {
    return "http://api.sunrise-sunset.org/json?lat=42.4534531&lng=-76.4756914"
}

public func sunMoonStuff() {
    if let url = URL(string: ssAPI()) {
        if let data = try? Data(contentsOf: url) {
            let json = JSON(data: data)
            if (json["status"] == "OK") {
                let sunrise = json["results"]["sunrise"].stringValue
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss a"
                dateFormatter.amSymbol = "AM"
                dateFormatter.pmSymbol = "PM"
                
                let sunriseDate = dateFormatter.date(from: sunrise)!
                let components = Calendar.current.dateComponents(in: NSTimeZone.local, from: sunriseDate)
                print("\(components.hour):\(components.minute)")
                
            }
        }
    }
}

public func currentWeather(hour: Int, completionHandler: @escaping () -> (time: String, temperature: Int, icon: UIImage)
{
//    if let url = URL(string: darkskyAPI()) {
//        if let allData = try? Data(contentsOf: url) {
//            let json = hour == 0 ? (JSON(data: allData))["currently"] : (JSON(data: allData))["hourly"]["data"][hour]
//            return getHourlyData(json: json)
//        }
//    }
//
//    return ("", 0, #imageLiteral(resourceName: "clear"))
    
    var returnData = ("", 0, #imageLiteral(resourceName: "clear"))
    Alamofire.request(darkskyAPI()).validate().responseJSON { response in
        switch response.result {
        case .success:
            if (response.result.value != nil) {
                let json = JSON(response.result.value!)
              
                let hourJson = hour == 0 ? json["currently"] : json["hourly"]["data"][hour]
                returnData = getHourlyData(json: hourJson)
                
        }
        
        case .failure(let error):
            print(error)
        }
    }
    return returnData
}

func celsiusToFahrenheit(celsius: Double) -> Int {
    return Int(celsius * 9/5 + 32)
}

func is12Hour () -> Bool {
    let formatter = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current)
    return (formatter?.contains("a"))!
}

func hourWithAmPm(hour: Int) -> String {
    var time = ""
    if (is12Hour()) {
        time = hour > 12 ? String(hour - 12) + ":00 pm" : String(hour) + ":00 am"
        if (hour == 12) { time = String(hour) + ":00 pm" }
    } else {
        time = hour > 12 ? String(hour) + ":00 pm" : String(hour) + ":00 am"
        if (hour == 0) { time = "12:00 am" }
    }
    return time
}

func getHourlyData(json:JSON) -> (time: String, temperature: Int, icon: UIImage) {
    let stupidHour = json["time"].doubleValue
    let date = Date(timeIntervalSince1970: stupidHour)
    let time = hourWithAmPm(hour: Calendar.current.component(.hour, from: date))
    
    let temp = temperatureSettings() == "F" ? celsiusToFahrenheit(celsius: json["apparentTemperature"].doubleValue) :
    Int(json["apparentTemperature"].doubleValue)
    
    var icon:UIImage! = nil
    switch json["icon"].stringValue {
    case "rain":
        icon = #imageLiteral(resourceName: "rain"); break
    case "snow":
        icon = #imageLiteral(resourceName: "snow"); break
    case "sleet":
        icon = #imageLiteral(resourceName: "sleet"); break
    case "fog":
        icon = #imageLiteral(resourceName: "fog"); break
    case "partly-cloudy-day", "partly-cloudy-night":
        icon = #imageLiteral(resourceName: "cloudy"); break
    default:
        icon = #imageLiteral(resourceName: "clear")
    }

    return (time, temp, icon)
}
