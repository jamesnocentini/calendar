import UIKit
import Foundation

public class DateDataSource: NSObject, UICollectionViewDataSource {
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.CalendarUnitDay, fromDate: DateManager.minimum, toDate: DateManager.maximum, options: NSCalendarOptions.allZeros)
        return components.day
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("d", forIndexPath: indexPath) as CalendarDateCell
        let components = NSDateComponents()
        components.day = indexPath.item
        let calendar = NSCalendar.currentCalendar()
        let newDate = calendar.dateByAddingComponents(components, toDate: DateManager.minimum, options: NSCalendarOptions(0))!
        let newDateComponents = calendar.components(NSCalendarUnit.CalendarUnitWeekday | NSCalendarUnit.CalendarUnitDay, fromDate: newDate)
        cell.textLabel.text = "\(newDateComponents.day)"
        let weekday = (SkoobrDatesFormatter.weekdaySymbols[newDateComponents.weekday - 1] as? String)!
        cell.dayLabel.text = weekday[0..<3]
        
        if newDateComponents.weekday == 7 || newDateComponents.weekday == 1 {
            cell.contentView.backgroundColor = DayWeekend.backgroundColor
            cell.dayLabel.textColor = DayWeekend.color
            cell.textLabel.textColor = DayWeekend.color
        } else {
            cell.contentView.backgroundColor = DayWeek.backgroundColor
            cell.dayLabel.textColor = DayWeek.color
            cell.textLabel.textColor = DayWeek.color
        }
        return cell
    }
    
}

extension String {
    subscript (r: Range<Int>) -> String {
        var start = advance(startIndex, r.startIndex)
            var end = advance(startIndex, r.endIndex)
            return substringWithRange(Range(start: start, end: end))
    }
}