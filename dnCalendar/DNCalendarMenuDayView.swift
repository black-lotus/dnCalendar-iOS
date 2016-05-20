//
//  DNCalendarMenuDayView.swift
//  dnCalendar
//
//  Created by romdoni agung purbayanto on 5/16/16.
//  Copyright © 2016 romdoni agung purbayanto. All rights reserved.
//

import UIKit

class DNCalendarMenuDayView: UIView {
    
    var dataSource: DNCalendarMenuDataSource!

    func build() {
        var dayNames: Array<String> = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thrusday", "Friday", "Saturday"]
        
        if let customDayNames: Array<String> = dataSource.dnCalendarMenuDayNames() {
            dayNames = customDayNames
        }
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var offset: CGFloat = 0
        
        // custom offset
        if let customOffset: CGFloat = dataSource.dnCalendarMenuDayOffset() {
            offset = customOffset
            y = customOffset
        }
        
        let width: CGFloat = (self.frame.size.width/7) - offset
        for i in 0..<dayNames.count {
            let view: UIView = UIView(frame: CGRectMake(x, y, width, self.frame.size.height - (offset * 2)))
            view.backgroundColor = UIColor.whiteColor()
            
            // custom background color
            if let customBackgroundColor: UIColor = dataSource.dnCalendarMenuBackgroundColor() {
                view.backgroundColor = customBackgroundColor
            }
            
            
            let label: UILabel = UILabel(frame: CGRectMake(0, 0, width, self.frame.size.height - (offset * 2)))
            label.textAlignment = NSTextAlignment.Center
            label.text = "\(dayNames[i])"
            
            // set font
            if let customFont: UIFont = dataSource.dnCalendarMenuFont() {
                label.font = customFont
            }
            
            // set label color
            if let labelColor: UIColor = dataSource.dnCalendarMenuLabelColor() {
                label.textColor = labelColor
            }
            
            // validate holiday
            if let holidays: Array<DNCalendarDayName> = dataSource.dnCalendarMenuHolidayWeeks() {
                for j in 0..<holidays.count {
                    let dayIndex: Int = holidays[j].rawValue
                    
                    if dayIndex == i {
                        if let holidayLabelColor: UIColor = dataSource.dnCalendarMenuHolidayLabelColor() {
                            label.textColor = holidayLabelColor
                        }
                        
                        break
                    }
                }
            }
            
            view.addSubview(label)
            
            self.addSubview(view)
            x = x + width + offset
        }
    }
    
}


