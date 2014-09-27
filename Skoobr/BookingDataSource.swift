import UIKit

public class CalendarDataSource: NSObject, UICollectionViewDataSource {
    public let cellIdentifier: String!
    public let bookings: [[Booking]]
    
    init(bookings: [[Booking]], cellIdentifier: String) {
        self.bookings = bookings
        self.cellIdentifier = cellIdentifier
        super.init()
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return bookings.count
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookings[section].count
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as CalendarBookingCell
        if let channel = bookings[indexPath.section][indexPath.item].channel {
            cell.channelLabel.text = channel
        } else {
            cell.channelLabel.hidden = true
        }
        cell.channelLabel.frame = CGRectMake(CGRectGetWidth(cell.frame) - 60, -10, 60, 20)
        cell.borderRight.frame = CGRectMake(CGRectGetWidth(cell.frame) - 4.0, 0, 4.0, CGRectGetHeight(cell.frame))
        
        return cell
    }
    
}