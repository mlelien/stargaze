//
//  Settings.swift
//  Stargaze
//
//  Created by Emily Lien on 1/8/17.
//  Copyright © 2017 EmilyLien. All rights reserved.
//

import Foundation

let defaults = UserDefaults.standard

func defaultSettings() {
    defaults.set("F", forKey: "temperature")
    defaults.set(true, forKey: "notifications")
    defaults.set(3, forKey: "notificationDays")
    defaults.set(true, forKey: "sunrise")
    defaults.set(true, forKey: "sunset")
    defaults.set(true, forKey: "moonrise")
    defaults.set(true, forKey: "moonset")
    //log in
    //calendar
    //locations
}


func temperatureSettings() -> String {
    return defaults.string(forKey: "temperature")!
}

func notificationsEnabled() -> Bool {
    return defaults.bool(forKey: "notifications")
}

func notifyDaysAdvance() -> Int {
    return defaults.integer(forKey: "notificationDays")
}

func sunriseEnabled() -> Bool {
    return defaults.bool(forKey: "sunrise")
}

func sunsetEnabled() -> Bool {
    return defaults.bool(forKey: "sunset")
}

func moonriseEnabled() -> Bool {
    return defaults.bool(forKey: "moonrise")
}

func moonsetEnabled() -> Bool {
    return defaults.bool(forKey: "moonset")
}
