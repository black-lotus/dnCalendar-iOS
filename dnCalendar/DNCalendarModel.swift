//
//  DNCalendarModel.swift
//  dnCalendar
//
//  Created by romdoni agung purbayanto on 5/11/16.
//  Copyright © 2016 romdoni agung purbayanto. All rights reserved.
//

import UIKit

public class DNCalendarModel {
    
    var weeks: Array<String> = Array<String>()
    var dayHeight: CGFloat = 0
    var dayOffset: CGFloat = 0
    
    var dataSource: DNCalendarDataSource?
    
    // public properperties
    public var presentedMonth: Int!
    public var presentedYear: Int!
    
    init(dataSource: DNCalendarDataSource?) {
        self.dataSource = dataSource
    }
    
    func getDayHeight() -> CGFloat {
        if dataSource != nil {
            return dataSource!.dnCalendarDayHeight()
        }
        
        return 30
    }
    
    func getDayOffset() -> CGFloat {
        if dataSource != nil {
            return dataSource!.dnCalendarDayOffset()
        }
        
        return 1
    }
    
    func getPresentedMonth() -> (month: Int, year: Int) {
        let cal = NSCalendar.currentCalendar()
        var date: NSDate = NSDate()
        
        if dataSource != nil {
            if let defaultDate = dataSource!.dnCalendarDefaultDate() {
                date = defaultDate
            }
        }
        
        let component: NSDateComponents = cal.components([NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: date)
        
        self.presentedMonth = component.month
        self.presentedYear = component.year
        
        return (month: component.month, year: component.year)
    }
    
    func isLessThanMinimumDate() -> Bool {
        var isLessThanMinimumDate: Bool = false
        
        if let dataSource = self.dataSource {
            let cal = NSCalendar.currentCalendar()
            if let minDate: NSDate = dataSource.dnCalendarMinDate() {
                let component: NSDateComponents = cal.components([NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: minDate)
                
                if component.year >= presentedYear {
                    if component.month >= presentedMonth {
                        isLessThanMinimumDate = true
                    }
                }
            }
        }
        
        
        return isLessThanMinimumDate
    }
    
    func isGreaterThanMaximumDate() -> Bool {
        var isGreaterThanMaximumDate: Bool = false
        
        if let dataSource = self.dataSource {
            let cal = NSCalendar.currentCalendar()
            if let maxDate: NSDate = dataSource.dnCalendarMaxDate() {
                let component: NSDateComponents = cal.components([NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: maxDate)
                
                if component.year <= presentedYear {
                    if component.month <= presentedMonth {
                        isGreaterThanMaximumDate = true
                    }
                }
            }
        }
        
        return isGreaterThanMaximumDate
    }
    
    func getWeekOfMonth(month: Int, year: Int) -> Array<Array<Int>> {
        var weeks: Array<Array<Int>> = Array<Array<Int>>()
        
        let cal = NSCalendar.currentCalendar()
        
        let currDate: NSDate = NSDate.parseStringIntoDate("\(year)-\(month)-1", format: "yyyy-MM-dd")
        let prevDate: NSDate = cal.dateByAddingUnit(.Month, value: -1, toDate: currDate, options: [])!
        
        let firstDateCurr: NSDate = currDate.startOfMonth()! // first date of current month
        let lastDateCurr: NSDate = currDate.endOfMonth()! // last date of current month
        let lastDatePrev: NSDate = prevDate.endOfMonth()! // last date of previous month
        
        let firstDateCurrComponents: NSDateComponents = cal.components(NSCalendarUnit.Day, fromDate: firstDateCurr)
        let firstDay: Int = firstDateCurrComponents.day
        
        let weekDayFirstMonth: Int = firstDateCurr.dayIndex() // 0: Sunday .. 6: Saturday
        
        let lastDateCurrComponents: NSDateComponents = cal.components(NSCalendarUnit.Day, fromDate: lastDateCurr)
        let numDays: Int = lastDateCurrComponents.day
        
        let lastDatePrevComponents: NSDateComponents = cal.components(NSCalendarUnit.Day, fromDate: lastDatePrev)
        let lastDayPrev: Int = lastDatePrevComponents.day
        
        var startPrevDay: Int = lastDayPrev - weekDayFirstMonth
        var startNextDay: Int = 1
        
        print("month \(month), year \(year) => \(numDays)")
        
        var date: Int = 1
        while (date <= numDays) {
            var i: Int = 0
            var tempWeek: Array<Int> = Array<Int>()
            
            while (i < 7) {
                // first column
                if weeks.count == 0 {
                    
                    if i >= weekDayFirstMonth {
                        tempWeek.append(date)
                        
                        date += 1
                    } else {
                        startPrevDay += 1
                        
                        tempWeek.append(startPrevDay)
                    }
                    
                } else {
                    
                    if date <= numDays {
                        tempWeek.append(date)
                        
                        date += 1
                    } else {
                        tempWeek.append(startNextDay)
                        
                        startNextDay += 1
                    }
                    
                }
                
                i += 1
            }
            
            weeks.append(tempWeek)
        }
        
        return weeks
    }
    
}