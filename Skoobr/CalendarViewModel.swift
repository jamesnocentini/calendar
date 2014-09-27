import Foundation
import UIKit

public class CalendarViewModel: NSObject {
    public var bookings: ([[Booking]])! = []
    public var properties: [Property]! = []
    public dynamic var dataSource: CalendarDataSource
    public var propertyDataSource: CalendarPropertyDataSource
    
    public override init() {
        SkoobrDatesFormatter.dateFormat = "YYYY-MM-dd"
        dataSource = CalendarDataSource(bookings: bookings, cellIdentifier: String(NSStringFromClass(CalendarBookingCell)))
        propertyDataSource = CalendarPropertyDataSource(properties: properties, cellIdentifier: "Property")
        super.init()
        self.loadContent()
    }
    
    public func loadContent() {
        
        // TODO: refactor this with promises
        // TODO: could use KVO
        CalendarController.request { (properties) -> () in
            self.properties = properties
            
            CalendarController.requestBookings { (bookings) -> () in
                var tmp: [[Booking]] = []
                for property in properties {
                    let a = bookings.filter({
                        (booking) in
                        return booking.property_id == property.id ? true : false
                    })
                    tmp.append(a)
                }
                self.bookings = tmp
                self.propertyDataSource = CalendarPropertyDataSource(properties: properties, cellIdentifier: "Property")
                self.dataSource = CalendarDataSource(bookings: self.bookings, cellIdentifier: String(NSStringFromClass(CalendarBookingCell)))
            }
            
        }
        
    }
    
}