//
//  DNCalendarDelegate.swift
//  dnCalendar
//
//  Created by romdoni agung purbayanto on 5/17/16.
//  Copyright © 2016 romdoni agung purbayanto. All rights reserved.
//

import UIKit

public protocol DNCalendarDelegate {

    func dnCalendarDidMoved(month: Int, year: Int)
    func dnCalendarDidSelectDay(dayView: DNCalendarDayView)

}
