//
//  DNCalendarView.swift
//  dnCalendar
//
//  Created by romdoni agung purbayanto on 5/16/16.
//  Copyright © 2016 romdoni agung purbayanto. All rights reserved.
//

import UIKit

public class DNCalendarView: UIView {
    
    public var calendarModel: DNCalendarModel!
    public var calendarViewController: DNCalendarViewController!
    public var dataSource: DNCalendarDataSource! {
        didSet {
            print("dataSource setup")
            calendarModel = DNCalendarModel(dataSource: dataSource)
        }
    }
    public var delegate: DNCalendarDelegate!
    
    private var validated = false
    
    public var (weekViewSize, dayViewSize): (CGSize?, CGSize?)
    
    
    // MARK: - Initialization
    
    public init() {
        super.init(frame: CGRectZero)
        // hidden = true
        
        print("DNCalendarView init")
        loadCalendar()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        // hidden = true
        
        print("DNCalendarView ovveride init")
        loadCalendar()
    }
    
    /// IB Initialization
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // hidden = true
        
        print("DNCalendarView required init")
        loadCalendar()
    }
    
    
    public func build() {
        if let viewController = calendarViewController {
            let viewSize = viewController.scrollView.bounds.size
            let selfSize = bounds.size
            let screenSize = UIScreen.mainScreen().bounds.size
            
            let allowed = selfSize.width <= screenSize.width && selfSize.height <= screenSize.height
            
            if !validated && allowed {
                let width = selfSize.width
                let height: CGFloat
                let countOfWeeks = CGFloat(6)
                
                let vSpace: CGFloat = 0
                let hSpace: CGFloat = 0
                
                height = (selfSize.height / countOfWeeks) - (vSpace * countOfWeeks)
                
                // no height constraint
                var found = false
                for constraint in constraints {
                    if constraint.firstAttribute == .Height {
                        found = true
                    }
                }
                
                if !found {
                    addConstraint(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: frame.height))
                }
                
                weekViewSize = CGSizeMake(width, height)
                dayViewSize = CGSizeMake((width / 7.0) - hSpace, height)
                validated = true
                
                viewController.updateFrames(selfSize != viewSize ? bounds : CGRectZero)
            }
        }
    }
    
}

// MARK: - Create scroll view

extension DNCalendarView {
    
    func loadCalendar() {
        calendarViewController = DNCalendarViewController(calendarView: self, frame: bounds)
        
        addSubview(calendarViewController.scrollView)
    }
    
}

