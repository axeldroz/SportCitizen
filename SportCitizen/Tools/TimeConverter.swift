//
//  TimeConverter.swift
//  SportCitizen
//
//  Created by Simon BRAMI on 20/02/2018.
//  Copyright © 2018 Simon BRAMI. All rights reserved.
//

import Foundation

class TimeConverter {
    
    private static func timeIntervalToString(stringInterval: String) -> Date?{
        let numFormat = NumberFormatter()
        numFormat.decimalSeparator = "."
        let double = numFormat.number(from: stringInterval)?.doubleValue
        let interval = TimeInterval(double!)
        var res: Date?
        res = Date(timeIntervalSince1970: interval)
        return res
    }
    
    public static func timeIntervalToTextDate(stringInterval: String) -> String {
        let res: Date? = timeIntervalToString(stringInterval: stringInterval)
        let formatDate = DateFormatter()
        formatDate.dateFormat = "MMM EEEE d"
        let date = formatDate.string(from: res!)
        return date
    }
    
    public static func timeIntervalToFrenchDate(stringInterval: String) -> String {
        let res: Date? = timeIntervalToString(stringInterval: stringInterval)
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd/MM/yyyy"
        let date = formatDate.string(from: res!)
        return date
    }
    
    public static func timeIntervalToEngWithHour(stringInterval: String) -> String {
        let res: Date? = timeIntervalToString(stringInterval: stringInterval)
        let formatDate = DateFormatter()
        formatDate.dateFormat = "MMM EEEE d, HH:mm"
        let date = formatDate.string(from: res!)
        return date
    }
    
    
    
}
