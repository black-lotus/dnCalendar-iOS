//
//  DNCalendarDayView.swift
//  dnCalendar
//
//  Created by romdoni agung purbayanto on 5/16/16.
//  Copyright © 2016 romdoni agung purbayanto. All rights reserved.
//

import UIKit

public class DNCalendarDayView: UIView {
    
    let date: NSDate
    
    private let cal: NSCalendar
    private let calendarView: DNCalendarView
    
    public init(date: NSDate, frame: CGRect, calendarView: DNCalendarView, isCurrentDate: Bool) {
        self.date = date
        self.cal = NSCalendar.currentCalendar()
        self.calendarView = calendarView
        super.init(frame: frame)
        
        let components: NSDateComponents = self.cal.components(NSCalendarUnit.Day, fromDate: date)
        let day: Int = components.day
        
        self.backgroundColor = UIColor.whiteColor()
        
        // add custom background color
        if let customBackgroundColor: UIColor = calendarView.dataSource.dnCalendarMainBackgroundColor() {
            self.backgroundColor = customBackgroundColor
        }
        
        let label: UILabel = UILabel(frame: frame)
        label.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        label.textAlignment = NSTextAlignment.Center
        label.text = "\(day)"
        
        // set font
        if let customFont: UIFont = calendarView.dataSource.dnCalendarMainFont() {
            label.font = customFont
        }
        
        // add label
        self.addSubview(label)
        
        // add custom label color
        if let customLabelColor: UIColor = calendarView.dataSource.dnCalendarMainLabelColor() {
            label.textColor = customLabelColor
        }
        
        // change background and color when isCurrentDate is false
        if isCurrentDate == false {
            if let customBackgroundColor: UIColor = calendarView.dataSource.dnCalendarPreBackgroundColor() {
                self.backgroundColor = customBackgroundColor
            }
            
            if let customLabelColor: UIColor = calendarView.dataSource.dnCalendarPreLabelColor() {
                label.textColor = customLabelColor
            }
        }
        
        // validate holiday weeks
        if let holidayWeeks: Array<DNCalendarDayName> = calendarView.dataSource.dnCalendarHolidayWeeks() {
            for i in 0..<holidayWeeks.count {
                let holidayIndexDay: Int = holidayWeeks[i].rawValue
                let indexDay: Int = date.dayIndex()
                
                // add holiday mark
                if holidayIndexDay == indexDay {
                    if isCurrentDate == true {
                        if let holidayLabelColor: UIColor = calendarView.dataSource.dnCalendarHolidayLabelColor() {
                            label.textColor = holidayLabelColor
                        }
                    } else {
                        if let holidayPreLabelColor: UIColor = calendarView.dataSource.dnCalendarHolidayPreLabelColor() {
                            label.textColor = holidayPreLabelColor
                        }
                    }
                    
                    if let holidayBackgroundColor: UIColor = calendarView.dataSource.dnCalendarHolidayBackgroundColor() {
                        self.backgroundColor = holidayBackgroundColor
                    }
                }
            }
        }
        
        // used to mark date must be disabled or not
        var disableDate: Bool = false
        
        // validate minimum date
        if let minDate: NSDate = calendarView.dataSource.dnCalendarMinDate() {
            if date.compare(minDate) == .OrderedAscending {
                disableDate = true
            }
        }
        
        // validate maximum date
        if let maxDate: NSDate = calendarView.dataSource.dnCalendarMaxDate() {
            if date.compare(maxDate) == .OrderedDescending {
                disableDate = true
            }
        }
        
        // add supplmentary view
        if let supplementView: UIView = calendarView.dataSource.dnCalendarSupplementaryView(date, frame: CGRectMake(0, 0, frame.size.width, frame.size.height)) {
            print("supplementView setup")
            self.addSubview(supplementView)
        }
        
        if let defaultDate: NSDate = calendarView.dataSource.dnCalendarDefaultDate() {
            if date.compare(defaultDate) == .OrderedSame {
                if let defaultDateView: UIView = calendarView.dataSource.dnCalendarDefaultDateView(CGRectMake(0, 0, frame.size.width, frame.size.height)) {
                    print("defaultView setup")
                    self.addSubview(defaultDateView)
                }
                
                if let defaultDateLabelColor: UIColor = calendarView.dataSource.dnCalendarDefaultDateLabelColor() {
                    label.textColor = defaultDateLabelColor
                }
            }
        }
        
        // disable view
        if disableDate == true {
            if let disabledView: UIView = calendarView.dataSource.dnCalendarDisabledView(CGRectMake(0, 0, frame.size.width, frame.size.height)) {
                print("disabled view setup")
                self.addSubview(disabledView)
            }
        } else {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(someAction))
            self.addGestureRecognizer(gesture)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func someAction(sender: UITapGestureRecognizer){
        print("date => \(self.date.description)")
        self.calendarView.delegate.dnCalendarDidSelectDay(self)
    }

}
