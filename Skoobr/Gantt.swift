import UIKit

public class GanttLayout: UICollectionViewLayout {
    public let bookings: ([[Booking]])!
    private var attributes: [UICollectionViewLayoutAttributes]!
    
    public init(bookings: [[Booking]]) {
        self.bookings = bookings
        super.init()
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func collectionViewContentSize() -> CGSize {
        let components = NSCalendar.currentCalendar().components(NSCalendarUnit.DayCalendarUnit, fromDate: DateManager.minimum, toDate: DateManager.maximum, options: NSCalendarOptions.allZeros)
        let width = components.day * ColumnWidth
        let height = bookings.count * RowHeight
        
        return CGSizeMake(CGFloat(width), CGFloat(height))
    }
    
    public override func prepareLayout() {
        self.attributes = calculateLayoutAttributes()
    }
    
    private func calculateLayoutAttributes() -> [UICollectionViewLayoutAttributes] {
        var attributes: [UICollectionViewLayoutAttributes] = []
        for i in 0..<bookings.count {
            for j in 0..<bookings[i].count {
                let indexPath = NSIndexPath(forItem: j, inSection: i)
                attributes.append(layoutAttributesForItemAtIndexPath(indexPath))
            }
        }
        return attributes
    }
    
    public override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        return attributes.filter { (attribute) -> Bool in
            return CGRectIntersectsRect(attribute.frame, rect) ? true : false
        }
    }
    
    public override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return false
    }
    
    public override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        let booking = bookings[indexPath.section][indexPath.item]
        let marginTop = CGFloat(indexPath.section * RowHeight)
        let marginLeft = CGFloat(marginLeftForItemAtIndexPath(booking))
        let width = CGFloat(widthForItemAtIndexPath(booking))
        let height = CGFloat(RowHeight)
        let frame = CGRectMake(marginLeft, marginTop, width, height)

        attributes.frame = CGRectInset(frame, 5, 10)
        attributes.zIndex = 2
        return attributes
    }
    
    private func marginLeftForItemAtIndexPath(booking: Booking) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let compoenents = calendar.components(NSCalendarUnit.CalendarUnitDay, fromDate: DateManager.minimum, toDate: booking.check_in, options: NSCalendarOptions.allZeros)
        return compoenents.day * ColumnWidth
    }
    
    private func widthForItemAtIndexPath(booking: Booking) -> Int {
        return booking.nights * ColumnWidth
    }
    
}