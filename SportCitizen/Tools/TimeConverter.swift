//
//  TimeConverter.swift
//  SportCitizen
//
//  Created by Simon BRAMI on 20/02/2018.
//  Copyright © 2018 Simon BRAMI. All rights reserved.
//

import Foundation

class TimeConverter {
    
    public static func timeIntervalToString(stringInterval: String) -> String{
        let numFormat = NumberFormatter()
        numFormat.decimalSeparator = "."
        let double = numFormat.number(from: stringInterval)?.doubleValue
        let interval = TimeInterval(double!)
        var res: Date?
        res = Date(timeIntervalSince1970: interval)
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd/MM/yyyy"
        let date = formatDate.string(from: res!)
        return date
    }
    
    
}
