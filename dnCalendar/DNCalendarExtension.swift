//
//  DNCalendarExtension.swift
//  dnCalendar
//
//  Created by romdoni agung purbayanto on 5/11/16.
//  Copyright © 2016 romdoni agung purbayanto. All rights reserved.
//

import UIKit

extension NSDate {
    func startOfMonth() -> NSDate? {
        let calendar = NSCalendar.currentCalendar()
        let currentDateComponents = calendar.components([.Year, .Month, .Day], fromDate: self)
        return calendar.dateFromComponents(currentDateComponents)
    }
    
    func endOfMonth() -> NSDate? {
        let calendar = NSCalendar.currentCalendar()
        let dayRange = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: self)
        let dayCount = dayRange.length
        let comp = calendar.components([.Year, .Month, .Day], fromDate: self)
        
        comp.day = dayCount
        
        return calendar.dateFromComponents(comp)!
    }
    
    func dayIndex() -> Int {
        let dayFormatter: NSDateFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "EEEE"
        dayFormatter.locale = NSLocale(localeIdentifier: "en-US")
        let strDayName: String = dayFormatter.stringFromDate(self)
        
        var index: Int = 0
        switch strDayName {
        case "Sunday":
            index = 0
            
        case "Monday":
            index = 1
            
        case "Tuesday":
            index = 2
            
        case "Wednesday":
            index = 3
            
        case "Thursday":
            index = 4
            
        case "Friday":
            index = 5
            
        case "Saturday":
            index = 6
            
        default:
            print("not found")
            
        }
        
        return index
    }
    
    class func parseStringIntoDate(input: String, format: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.dateFromString(input)!
    }
}

extension UIView {
    public func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}