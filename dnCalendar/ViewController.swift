//
//  ViewController.swift
//  dnCalendar
//
//  Created by romdoni agung purbayanto on 5/11/16.
//  Copyright © 2016 romdoni agung purbayanto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var menuDayCalendarView: DNCalendarMenuDayView!
    @IBOutlet weak var calendarView: DNCalendarView!
    @IBOutlet weak var calendarMonthLabel: UILabel!
    @IBOutlet weak var calendarPrevMonthLabel: UILabel!
    @IBOutlet weak var calendarNextMonthLabel: UILabel!
    
    var monthNames: Array<String> = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.monthNames = [ "JANUARI", "FEBRUARI", "MARET", "APRIL", "MEI", "JUNI", "JULI", "AGUSTUS", "SEPTEMBER", "OKTOBER", "NOVEMBER", "DESEMBER" ]
        calendarView.dataSource = self
        calendarView.delegate = self
        menuDayCalendarView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        menuDayCalendarView.build()
        calendarView.build()
    }

}

extension ViewController: DNCalendarDataSource {
    
    func dnCalendarDayOffset() -> CGFloat {
        return 1
    }
    
    func dnCalendarDayHeight() -> CGFloat {
        return 55
    }
    
    func dnCalendarSupplementaryView(date: NSDate, frame: CGRect) -> UIView? {
        let today = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
        
        if (date.compare(today) == .OrderedSame) {
            let view: UIView = UIView(frame: CGRectMake(0, frame.size.height - 5, frame.size.width, 5))
            view.backgroundColor = UIColor(red: 245/255, green: 134/255, blue: 52/255, alpha: 1)
            
            return view
        }
        
        return nil
    }
    
    func dnCalendarDefaultDateView(frame: CGRect) -> UIView? {
        let view: UIView = UIView(frame: CGRectMake(-1, -1, frame.size.width + 2, frame.size.height + 2))
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(red: 245/255, green: 134/255, blue: 52/255, alpha: 1).CGColor
        
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: frame.size.height - 15, width: frame.size.width, height: 10))
        label.textColor = UIColor(red: 245/255, green: 134/255, blue: 52/255, alpha: 1)
        label.font = UIFont.systemFontOfSize(10)
        label.textAlignment = NSTextAlignment.Center
        label.text = "default"
        
        view.addSubview(label)
        return view
    }
    
    func dnCalendarDefaultDateLabelColor() -> UIColor? {
        return UIColor(red: 245/255, green: 134/255, blue: 52/255, alpha: 1)
    }
    
    func dnCalendarMinDate() -> NSDate? {
        let date: NSDate = NSDate.parseStringIntoDate("2016-05-10", format: "yyyy-MM-dd")
        return date
    }
    
    func dnCalendarMaxDate() -> NSDate? {
        let date: NSDate = NSDate.parseStringIntoDate("2016-12-30", format: "yyyy-MM-dd")
        return date
    }
    
    func dnCalendarDefaultDate() -> NSDate? {
        let date: NSDate = NSDate.parseStringIntoDate("2016-05-12", format: "yyyy-MM-dd")
        return date
    }
    
    func dnCalendarDisabledView(frame: CGRect) -> UIView? {
        let view: UIView = UIView(frame: frame)
        view.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.1)
        
        return view
    }
    
    func dnCalendarHolidayWeeks() -> Array<DNCalendarDayName>? {
        return [DNCalendarDayName.Sunday, DNCalendarDayName.Saturday]
    }
    
    func dnCalendarHolidayLabelColor() -> UIColor? {
        return UIColor(red: 230/255, green: 44/255, blue: 44/255, alpha: 1)
    }
    
    func dnCalendarHolidayBackgroundColor() -> UIColor? {
        return nil
    }
    
    func dnCalendarMainBackgroundColor() -> UIColor? {
        return UIColor.whiteColor()
    }
    
    func dnCalendarMainLabelColor() -> UIColor? {
        return UIColor(red: 66/255, green: 87/255, blue: 98/255, alpha: 1)
    }
    
    func dnCalendarMainFont() -> UIFont {
        return UIFont.systemFontOfSize(14)
    }
    
    func dnCalendarPreBackgroundColor() -> UIColor? {
        return UIColor.whiteColor()
    }
    
    func dnCalendarPreLabelColor() -> UIColor? {
        return UIColor(red: 202/255, green: 212/255, blue: 217/255, alpha: 1)
    }
    
    func dnCalendarHolidayPreLabelColor() -> UIColor? {
        return UIColor(red: 243/255, green: 136/255, blue: 136/255, alpha: 1)
    }
    
}

extension ViewController: DNCalendarDelegate {
    
    func dnCalendarDidMoved(month: Int, year: Int) {
        var prevMonth: Int = month - 1
        
        if prevMonth < 1 {
            prevMonth = 12
        }
        
        var nextMonth: Int = month + 1
        
        if nextMonth > 12 {
            nextMonth = 1
        }
        
        var prevMonthVal: String = self.monthNames[prevMonth - 1]
        var nextMonthVal: String = self.monthNames[nextMonth - 1]
        
        prevMonthVal = prevMonthVal[Range(start: prevMonthVal.startIndex.advancedBy(0), end: prevMonthVal.startIndex.advancedBy(3))]
        nextMonthVal = nextMonthVal[Range(start: nextMonthVal.startIndex.advancedBy(0), end: nextMonthVal.startIndex.advancedBy(3))]
        
        self.calendarPrevMonthLabel.text = prevMonthVal
        self.calendarNextMonthLabel.text = nextMonthVal
        self.calendarMonthLabel.text = "\(self.monthNames[month - 1]) \(year)"
    }
    
    func dnCalendarDidSelectDay(dayView: DNCalendarDayView) {
        let cal: NSCalendar = NSCalendar.currentCalendar()
        let components: NSDateComponents = cal.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: dayView.date)
        let day: Int = components.day
        let month: Int = components.month
        let year: Int = components.year
        
        print("day => \(day), month => \(month), year => \(year)")
    }
    
}

extension ViewController: DNCalendarMenuDataSource {
    
    func dnCalendarMenuDayNames() -> Array<String>? {
        return ["MIN", "SEN", "SEL", "RAB", "KAM", "JUM", "SAB"]
    }
    
    func dnCalendarMenuHolidayWeeks() -> Array<DNCalendarDayName>? {
        return [DNCalendarDayName.Sunday, DNCalendarDayName.Saturday]
    }
    
    func dnCalendarMenuHolidayLabelColor() -> UIColor? {
        return UIColor(red: 230/255, green: 44/255, blue: 44/255, alpha: 1)
    }
    
    func dnCalendarMenuLabelColor() -> UIColor? {
        return UIColor(red: 66/255, green: 87/255, blue: 98/255, alpha: 1)
    }
    
    func dnCalendarMenuBackgroundColor() -> UIColor? {
        return UIColor.whiteColor()
    }
    
    func dnCalendarMenuDayOffset() -> CGFloat {
        return 1
    }
    
    func dnCalendarMenuFont() -> UIFont {
        return UIFont.systemFontOfSize(12)
    }
    
}

