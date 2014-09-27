import UIKit

extension UIView {
    public var topBorder: Bool {
        get {
            return false
        }
        set {
            let layer = CALayer()
            layer.backgroundColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.722, alpha: 1).CGColor
            layer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.5)
            self.layer.addSublayer(layer)
        }
    }
    public var bottomBorder: Bool {
        get {
            return false
        }
        set {
            let layer = CALayer()
            layer.backgroundColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.722, alpha: 1).CGColor
            layer.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 0.5)
            self.layer.addSublayer(layer)
        }
    }
}

extension UITextField {
    public var borderColor: UIColor {
        get {
            return UIColor(CGColor: self.layer.borderColor)
        }
        set {
            self.layer.borderColor = newValue.CGColor
        }
    }
    
    public var topRadius: Bool {
        get {
            return false
        }
        set {
            print("yes!")
            let bezier = UIBezierPath(roundedRect: bounds, byRoundingCorners: (UIRectCorner.TopRight | UIRectCorner.TopLeft), cornerRadii: CGSizeMake(4.0, 4.0))
            let mask = CAShapeLayer()
            mask.frame = bounds
            mask.path = bezier.CGPath
            layer.mask = mask
        }
    }
    
    public var bottomRadius: Bool {
        get {
            return false
        }
        set {
            let bezier = UIBezierPath(roundedRect: bounds, byRoundingCorners: (UIRectCorner.BottomLeft | UIRectCorner.BottomRight), cornerRadii: CGSizeMake(4.0, 4.0))
            let mask = CAShapeLayer()
            mask.frame = bounds
            mask.path = bezier.CGPath
            layer.mask = mask
        }
    }
}