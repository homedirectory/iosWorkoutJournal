//
//  Extensions.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 14.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var id: String {
        String(describing: Self.self)
    }
}

extension UICollectionViewCell {
    static var id: String {
        String(describing: Self.self)
    }
}

extension Double {
    var kmString: String {
        var result = "-"
        if Int((self / 10)) % 10 == 0 {
            result = "\(Int(self/1000)) km"
        }
        else {
            result = String(format: "%.1f km", self/1000)
        }
        return result
    }
    
    var secondsString: String {
        let hours = floor(self / 3600)
        let minutes = (self - (hours * 3600)) / 60
        var result = ""
        if self >= 3600 {
            result = "\(Int(hours)) h "
        }
        if self.truncatingRemainder(dividingBy: 3600) != 0 {
            result += "\(Int(minutes)) min"
        }
        return result.isEmpty ? "-" : result
    }
    
    var kmPerHourString: String {
        var result = "-"
        if (self * 10).truncatingRemainder(dividingBy: 10) == 0 {
            result = "\(Int(self)) km/h"
        }
        else {
            result = String(format: "%.1f km/h", self)
        }
        return result
    }
}

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
