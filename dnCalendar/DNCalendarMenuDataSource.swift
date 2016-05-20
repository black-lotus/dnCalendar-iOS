//
//  DNCalendarMenuDataSource.swift
//  dnCalendar
//
//  Created by romdoni agung purbayanto on 5/16/16.
//  Copyright © 2016 romdoni agung purbayanto. All rights reserved.
//

import UIKit

public protocol DNCalendarMenuDataSource {
    
    // MARK: - Day Names
    func dnCalendarMenuDayNames() -> Array<String>?
    
    // MARK: - Holiday Weeks
    func dnCalendarMenuHolidayWeeks() -> Array<DNCalendarDayName>?
    
    // MARK: - Label color for holiday
    func dnCalendarMenuHolidayLabelColor() -> UIColor?
    
    // MARK: - Label color
    func dnCalendarMenuLabelColor() -> UIColor?
    
    // MARK: - Main background color
    func dnCalendarMenuBackgroundColor() -> UIColor?
    
    // MARK: - Offset between day view
    func dnCalendarMenuDayOffset() -> CGFloat
    
    // MARK: - Main label font
    func dnCalendarMenuFont() -> UIFont
    
}
