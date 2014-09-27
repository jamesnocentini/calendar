import Foundation

public struct DateManager {
    
    public static var today = NSDate()
    
    public static var maximum: NSDate {
        get {
            let dateComponents = NSDateComponents()
            dateComponents.month = 6
            let calendar = NSCalendar.currentCalendar()
            let newDate = calendar.dateByAddingComponents(dateComponents, toDate: today, options: NSCalendarOptions.allZeros)!
            return newDate
        }
    }
    
    public static var minimum: NSDate {
        get {
            let dateComponents = NSDateComponents()
            dateComponents.month = -1
            let calendar = NSCalendar.currentCalendar()
            let newDate = calendar.dateByAddingComponents(dateComponents, toDate: today, options: NSCalendarOptions.allZeros)!
            return newDate
        }
    }
    
}