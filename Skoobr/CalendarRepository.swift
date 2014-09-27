import Foundation

struct CalendarController {
    
    
        static func requestBookings(completionHandler: (bookings: [Booking]) -> ()) {
            
            Manager.shared.request(.GET, URL: "http://www.skoobr.com/api/bookings?from=2014-8-1&to=2015-03-31") { (json, response, error) -> () in
    
                if let jsonUnwrapped = json as? [String : AnyObject] {
    
                    if let bookings = jsonUnwrapped["bookings"] as AnyObject? as? [[String : AnyObject]] {
                        var bookingsArray: [Booking] = []
                        for aBooking in bookings {
//                            if let state = aBooking["state"] as AnyObject? as? String {
//                                if state == "confirmed" {
                                    let booking = Booking(json: aBooking as [String : AnyObject])
                                    bookingsArray.append(booking)
//                                }
//                            }
                        }
                        completionHandler(bookings: bookingsArray)
                    }
    
                }
                
            }
        }
    
    static func request(completionHandler: (properties: [Property]) -> ()) {
        Manager.shared.request(.GET, URL: "http://www.skoobr.com/api/properties") { (json, response, error) -> () in
            
            if let jsonUnwrapped = json as? [String : AnyObject] {
                
                if let properties = jsonUnwrapped["properties"] as AnyObject? as? [[String : AnyObject]] {
                    var propertiesArray: [Property] = []
                    for aProperty in properties {
                        let property = Property(json: aProperty)
                        propertiesArray.append(property)
                    }
                    completionHandler(properties: propertiesArray)
                }
                
            }
            
        }
    }

    
}