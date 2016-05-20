# dnCalendar-iOS
simple and light calendar built with swift

<img src="https://github.com/black-lotus/dnCalendar-iOS/blob/master/screenshot.png"/>

# iOS Supports
- iOS 8 or Higher

DNCalendar DOES require Xcode 7 and Swift 2.0.

**Usage**    
========

Using DNCalendar isn't difficult at all. 
So let's get started.

<h3> Storyboard Setup </h3>


Now you're about to add 2 UIViews to your Storyboard as it shown in the picture below.

![alt tag](https://github.com/black-lotus/dnCalendar-iOS/blob/master/storyboard.png)

Don't forget to add 2 outlets into your code.
```swift
    @IBOutlet weak var menuDayCalendarView: DNCalendarMenuDayView!
    @IBOutlet weak var calendarView: DNCalendarView!
```

Two views are representing ultimately a MenuView and a CalendarView so they should have corresponding classes. To change their classes go to <b>Identity Inspector</b> and set custom classes. When it's done, you'll see in the dock panel something similar to the picture below.  (Big Gray UIView -> DNCalendarView, Small Gray UIView -> DNCalendarMenuDayView)

![alt tag](https://github.com/black-lotus/dnCalendar-iOS/blob/master/structure.png)


<h5> Important note. </h5>

Before we move to setting up delegates for customization stuff, you should know that CalendarView's initialization is devided by 2 parts:
* On Init.
* On Layout.

As well as most of the developers are using AutoLayout feature UIView's size in the beginning of initialization does not match the one on UIView's appearing. 

Since DNCalendarView and DNCalendarMenuDayView will be created automatically all you have to do is this.

````swift
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        menuDayCalendarView.build()
        calendarView.build()
    }
````

<h4>DataSource Setup</h4>

DNCalendar requires to implement two dataSource. They are <b>DNCalendarDataSource</b> and <b>DNCalendarMenuDataSource</b>. Note that the last one has exactly the same named method as the first one declares which means you have to implement only required methods in <b>DNCalendarDataSource</b> and set your controller as a dataSource implementing both protocols.

DNCalendarDataSource customizable properties:
* day view height
* day view offset
* supplementary view
* default date
* default date label color
* default date view
* disabled view
* min date
* max date
* holiday weeks
* holiday label color
* holiday background color
* main background color
* main label color
* main label font
* pre background color
* pre label color
* holiday pre label color

DNCalendarMenuDataSource customizable properties:
* day names
* holiday weeks
* holiday label color
* main label color
* main background color
* day offset
* main label font


<h4>Delegate Setup</h4>

DNCalendar require to implement one delegate <b>DNCalendarDelegate</b>. Set your controller as a delegate implementing this protocols.

DNCalendarDelegate behavior:
* calendar did moved (called when scroll to the left or right)
* calendar did select day view

Do NOT forget to connect a particular outlet with your ViewController if you're implementing its protocol.






