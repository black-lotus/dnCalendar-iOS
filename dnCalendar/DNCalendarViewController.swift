//
//  DNCalendarViewController.swift
//  dnCalendar
//
//  Created by romdoni agung purbayanto on 5/16/16.
//  Copyright © 2016 romdoni agung purbayanto. All rights reserved.
//

import UIKit

public class DNCalendarViewController: UIViewController {
    
    // MARK: - Public Properties
    public let calendarView: DNCalendarView
    public let scrollView: UIScrollView
    public var dateSize: CGSize = CGSize()
    
    // MARK: - Private Properties
    private var lastContentOffset: CGFloat!
    private var frame: CGRect!
    
    public init(calendarView: DNCalendarView, frame: CGRect) {
        print("DNCalendarViewController init")
        self.calendarView = calendarView
        scrollView = UIScrollView(frame: frame)
        
        super.init(nibName: nil, bundle: nil)
        
        scrollView.contentSize = CGSizeMake(frame.width * 3, frame.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.layer.masksToBounds = true
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        
        self.frame = frame
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Scroll View

extension DNCalendarViewController: UIScrollViewDelegate {
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.x
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if (self.lastContentOffset! < scrollView.contentOffset.x) {
            print("MOVE TO LEFT")
            
            // moved right
            increasePresentedDate()
            
            // send back to delegate
            calendarView.delegate.dnCalendarDidMoved(calendarView.calendarModel.presentedMonth, year: calendarView.calendarModel.presentedYear)
            
            // re-draw calendar
            draw()
        } else if (self.lastContentOffset! > scrollView.contentOffset.x) {
            print("MOVE TO RIGHT")
            
            // moved left
            decreasePresentedDate()
            
            // send back to delegate
            calendarView.delegate.dnCalendarDidMoved(calendarView.calendarModel.presentedMonth, year: calendarView.calendarModel.presentedYear)
            
            // re-draw calendar
            draw()
        } else {
            // didn't move
            print("DIDN'T MOVE")
        }
    }
    
    private func increasePresentedDate() {
        calendarView.calendarModel.presentedMonth = calendarView.calendarModel.presentedMonth + 1
        if calendarView.calendarModel.presentedMonth > 12 {
            calendarView.calendarModel.presentedMonth = 1
            calendarView.calendarModel.presentedYear = calendarView.calendarModel.presentedYear + 1
        }
    }
    
    private func decreasePresentedDate() {
        calendarView.calendarModel.presentedMonth = calendarView.calendarModel.presentedMonth - 1
        if calendarView.calendarModel.presentedMonth <= 0 {
            calendarView.calendarModel.presentedMonth = 12
            calendarView.calendarModel.presentedYear = calendarView.calendarModel.presentedYear - 1
        }
    }
    
}

// MARK: - UI Refresh

extension DNCalendarViewController {
    public func updateFrames(frame: CGRect) {
        print("DNCalendarViewController updateFrames")
        if frame != CGRectZero {
            self.frame = frame
            scrollView.frame = frame
            scrollView.removeAllSubviews()
        }
        
        let presented: (month: Int, year: Int) = calendarView.calendarModel.getPresentedMonth()
        
        calendarView.calendarModel.presentedMonth = presented.month
        calendarView.calendarModel.presentedYear = presented.year
        
        let width: CGFloat = (frame.size.width/7) - calendarView.calendarModel.getDayOffset()
        let height: CGFloat = calendarView.calendarModel.getDayHeight() - calendarView.calendarModel.getDayOffset()
        dateSize = CGSize(width: width, height: height)
        calendarView.hidden = false
        
        // send back to delegate
        calendarView.delegate.dnCalendarDidMoved(calendarView.calendarModel.presentedMonth, year: calendarView.calendarModel.presentedYear)
        
        // draw calendar
        draw()
    }
}

extension DNCalendarViewController {
    
    func draw() {
        var showPrevMonth: Bool = true
        var showNextMonth: Bool = true

        if calendarView.calendarModel.isLessThanMinimumDate() == true {
            showPrevMonth = false
        }
        
        if calendarView.calendarModel.isGreaterThanMaximumDate() == true {
            showNextMonth = false
        }
        
        // remove all subview
        scrollView.removeAllSubviews()
        
        // update content of scrollview
        let totalPrintedMonth = (showPrevMonth == false || showNextMonth == false ) ? 2 : 3
        scrollView.contentSize = CGSizeMake(self.calendarView.frame.size.width * CGFloat(totalPrintedMonth), self.calendarView.frame.size.height)
        
        // set content offset when totalPrintedMonth is 3
        if totalPrintedMonth == 3 {
            scrollView.contentOffset = CGPointMake( (scrollView.contentSize.width/2) - (scrollView.bounds.width/2), 0)
        }
        
        if showPrevMonth == true {
            var previosMonth: Int = calendarView.calendarModel.presentedMonth - 1
            var previousYear: Int = calendarView.calendarModel.presentedYear
            if previosMonth < 1 {
                previosMonth = 12
                previousYear = previousYear - 1
                
            }
            
            let previousView: UIView = drawMonth(previosMonth, year: previousYear)
            insertMonthView(previousView, withIdentifier: "previous", showPrevious: showPrevMonth, showFollowing: showNextMonth)
        }
        
        if showNextMonth == true {
            var followingMonth: Int = calendarView.calendarModel.presentedMonth + 1
            var followingYear: Int = calendarView.calendarModel.presentedYear
            if followingMonth > 12 {
                followingMonth = 1
                followingYear = followingYear + 1
            }
            
            let followingView: UIView = drawMonth(followingMonth, year: followingYear)
            insertMonthView(followingView, withIdentifier: "following", showPrevious: showPrevMonth, showFollowing: showNextMonth)
        }
        
        let presentedView: UIView = drawMonth(calendarView.calendarModel.presentedMonth, year: calendarView.calendarModel.presentedYear)
        insertMonthView(presentedView, withIdentifier: "presented", showPrevious: showPrevMonth, showFollowing: showNextMonth)
        
        // update height of scroll view
        self.updateHeight(presentedView.frame.size.height)
    }
    
    func insertMonthView(view: UIView, withIdentifier identifier: String, showPrevious: Bool, showFollowing: Bool) {
        let index: CGFloat
        switch identifier {
        case "previous": index = 0
        case "presented": index = (showPrevious == true) ? 1 : 0
        case "following": index = (showPrevious == true) ? 2 : 1
        default: index = -1
        }
        
        view.frame.origin = CGPoint(x: scrollView.bounds.width * index, y: 0)
        scrollView.addSubview(view)
    }
    
    func drawMonth(month: Int, year: Int) -> UIView {
        let dates: Array<Array<Int>> = calendarView.calendarModel.getWeekOfMonth(month, year: year)
        
        let viewHeight: CGFloat = dateSize.height * CGFloat(dates.count) + (calendarView.calendarModel.getDayOffset() * CGFloat(dates.count)) + calendarView.calendarModel.getDayOffset()
        let view: UIView = UIView(frame: CGRect(origin: calendarView.frame.origin, size: CGSize(width: calendarView.frame.width, height: viewHeight)))
        
        var x: CGFloat = 0
        var y: CGFloat = calendarView.calendarModel.getDayOffset()
        for i in 0..<dates.count {
            for j in 0..<dates[i].count {
                var isCurrentDate: Bool = true
                
                // temporary identity
                var tempYear = year
                var tempMonth = month
                
                // first row of dates
                if i == 0 && dates[i][j] > 7 {
                    isCurrentDate = false
                    tempMonth = tempMonth - 1
                    
                    if tempMonth <= 0 {
                        tempMonth = 12
                        tempYear = tempYear - 1
                    }
                }
                
                // last row of dates
                if i == (dates.count - 1) && dates[i][j] <= 7 {
                    isCurrentDate = false
                    tempMonth = tempMonth + 1
                    
                    if tempMonth > 12 {
                        tempMonth = 1
                        tempYear = tempYear + 1
                    }
                }
                
                let date: NSDate = NSDate.parseStringIntoDate("\(tempYear)-\(tempMonth)-\(dates[i][j])", format: "yyyy-MM-dd")
                let dayView: DNCalendarDayView = DNCalendarDayView(date: date, frame: CGRectMake(x, y, dateSize.width, dateSize.height), calendarView: self.calendarView, isCurrentDate: isCurrentDate)
                
                view.addSubview(dayView)
                
                x = x + dateSize.width + calendarView.calendarModel.getDayOffset()
            }
            
            x = 0
            y = y + dateSize.height + calendarView.calendarModel.getDayOffset()
        }
        
        return view
    }
    
    private func updateHeight(height: CGFloat) {
        scrollView.contentSize.height = height
        
        var viewsToLayout = [UIView]()
        if let calendarSuperview = calendarView.superview {
            for constraintIn in calendarSuperview.constraints {
                if let firstItem = constraintIn.firstItem as? UIView,
                    let _ = constraintIn.secondItem as? DNCalendarView {
                    
                    viewsToLayout.append(firstItem)
                }
            }
        }
        
        
        for constraintIn in calendarView.constraints where
            constraintIn.firstAttribute == NSLayoutAttribute.Height {
                constraintIn.constant = height
                
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                    self.layoutViews(viewsToLayout, toHeight: height)
                    }, completion: nil)
                
                break
        }
    }
    
    private func layoutViews(views: [UIView], toHeight height: CGFloat) {
        scrollView.frame.size.height = height
        
        var superStack = [UIView]()
        var currentView: UIView = calendarView
        while let currentSuperview = currentView.superview where !(currentSuperview is UIWindow) {
            superStack += [currentSuperview]
            currentView = currentSuperview
        }
        
        for view in views + superStack {
            view.layoutIfNeeded()
        }
    }
    
}

