//
//  DNCalendarDelegate.swift
//  dnCalendar
//
//  Created by romdoni agung purbayanto on 5/16/16.
//  Copyright © 2016 romdoni agung purbayanto. All rights reserved.
//

import UIKit

public protocol DNCalendarDataSource {

    // MARK: - Height of day view
    func dnCalendarDayHeight() -> CGFloat
    
    // MARK: - Offset between day view
    func dnCalendarDayOffset() -> CGFloat
    
    // MARK: - Supplmentary view in day view
    func dnCalendarSupplementaryView(date: NSDate, frame: CGRect) -> UIView?
    
    // MARK: - Default date view in day view
    func dnCalendarDefaultDateView(frame: CGRect) -> UIView?
    
    // MARK: - Default date label color in day view
    func dnCalendarDefaultDateLabelColor() -> UIColor?
    
    // MARK: - Disabled View for min date and max date
    func dnCalendarDisabledView(frame: CGRect) -> UIView?
    
    // MARK: - Minimum date
    func dnCalendarMinDate() -> NSDate?
    
    // MARK: - Maximum date
    func dnCalendarMaxDate() -> NSDate?
    
    // MARK: - Default date
    func dnCalendarDefaultDate() -> NSDate?
    
    // MARK: - Holiday Weeks
    func dnCalendarHolidayWeeks() -> Array<DNCalendarDayName>?
    
    // MARK: - Label color for holiday
    func dnCalendarHolidayLabelColor() -> UIColor?
    
    // MARK: - Background color for holiday
    func dnCalendarHolidayBackgroundColor() -> UIColor?

    // MARK: - Main background color
    func dnCalendarMainBackgroundColor() -> UIColor?
    
    // MARK: - Main label color
    func dnCalendarMainLabelColor() -> UIColor?
    
    // MARK: - Main label font
    func dnCalendarMainFont() -> UIFont
    
    // MARK: - Main previous and following background color
    func dnCalendarPreBackgroundColor() -> UIColor?
    
    // MARK: - Main previous and following label color
    func dnCalendarPreLabelColor() -> UIColor?
    
    // MARK: - Main previous and following label color for holiday
    func dnCalendarHolidayPreLabelColor() -> UIColor?
    
    
}
