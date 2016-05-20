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
        guard
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components([.Year, .Month], fromDate: self) else { return nil }
        comp.to12pm()
        return cal.dateFromComponents(comp)!
    }
    
    func endOfMonth() -> NSDate? {
        guard
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = NSDateComponents() else { return nil }
        comp.month = 1
        comp.day -= 1
        comp.to12pm()
        return cal.dateByAddingComponents(comp, toDate: self.startOfMonth()!, options: [])!
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

internal extension NSDateComponents {
    func to12pm() {
        self.hour = 12
        self.minute = 0
        self.second = 0
    }
}

extension UIView {
    public func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}