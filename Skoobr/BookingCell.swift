import UIKit

class CalendarBookingCell: UICollectionViewCell {
    let channelLabel: UILabel
    let borderLeft: CAShapeLayer
    let borderRight: CAShapeLayer
    
    override init(frame: CGRect) {
        let rect = CGRectMake(CGRectGetWidth(frame) - 60, -10, 60, 20)
        
        channelLabel = UILabel(frame: rect)
        channelLabel.textColor = UIColor.whiteColor()
        channelLabel.font = UIFont.boldSystemFontOfSize(10.0)
        channelLabel.layer.masksToBounds = true
        channelLabel.textAlignment = NSTextAlignment.Center
        channelLabel.backgroundColor = ChannelBadgeBackgroundColor
        channelLabel.layer.cornerRadius = 5.0
        channelLabel.layer.borderWidth = 2.0
        channelLabel.layer.borderColor = UIColor.whiteColor().CGColor
        
        borderLeft = CAShapeLayer()
        borderLeft.backgroundColor = DarkGreenEdge.CGColor
        
        
        borderRight = CAShapeLayer()
        borderRight.backgroundColor = DarkGreenEdge.CGColor
        
        super.init(frame: frame)
        
        borderLeft.frame = CGRectMake(0, 0, 4.0, CGFloat(RowHeight - 20))
        borderRight.frame = CGRectMake(CGRectGetWidth(contentView.frame) - 4.0, 0, 4.0, CGRectGetHeight(contentView.frame))
        
        contentView.layer.addSublayer(borderLeft)
        contentView.layer.addSublayer(borderRight)
        
        contentView.backgroundColor = BookingColor
        contentView.addSubview(channelLabel)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        channelLabel.text = ""
        channelLabel.hidden = false
    }
    
}