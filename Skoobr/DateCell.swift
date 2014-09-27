import UIKit

class CalendarDateCell: UICollectionViewCell {
    let textLabel: UILabel
    let dayLabel: UILabel
    
    override init(frame: CGRect) {
        let rect = CGRectMake(0, 20, CGRectGetWidth(frame), 20)
        let rect2 = CGRectMake(0, 40, CGRectGetWidth(frame), 20)
        textLabel = UILabel(frame: CGRectInset(rect, 0, 0))
        textLabel.textAlignment = NSTextAlignment.Center
        dayLabel = UILabel(frame: rect2)
        dayLabel.textAlignment = NSTextAlignment.Center
        dayLabel.font = UIFont.boldSystemFontOfSize(12.0)
        super.init(frame: frame)
        contentView.addSubview(textLabel)
        contentView.addSubview(dayLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel.text = ""
        dayLabel.text = ""
    }
    
}