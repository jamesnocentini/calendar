// Playground - noun: a place where people can play

import UIKit




//let usernameMaskPathWithRadiusTop = UIBezierPath(roundedRect: textField.bounds, byRoundingCorners: (UIRectCorner.TopLeft | UIRectCorner.TopRight), cornerRadii: CGSizeMake(4.0, 4.0))
//let mask = CAShapeLayer()
//mask.frame = textField.bounds
//mask.path = usernameMaskPathWithRadiusTop.CGPath
//textField.layer.mask = mask
//textField.backgroundColor = UIColor.whiteColor()
//textField.layer.backgroundColor = UIColor.clearColor().CGColor
//textField.backgroundColor = UIColor.whiteColor()
//view

extension UITextField {
    public var topRadius: Bool {
        get {
            return false
        }
        set {
            let bezier = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: (UIRectCorner.TopLeft | UIRectCorner.TopRight), cornerRadii: CGSizeMake(4.0, 4.0))
            let mask = CAShapeLayer()
            mask.frame = self.bounds
            mask.path = bezier.CGPath
            self.layer.mask = mask
        }
    }
}

let view = UIView(frame: CGRectMake(0, 0, 200, 200))
view.backgroundColor = UIColor.redColor()
let textField = UITextField(frame: CGRectMake(30, 10, 70, 20))
textField.backgroundColor = UIColor.whiteColor()
textField.text = "Hey"
textField.topRadius = true

view.addSubview(textField)
view

//CAShapeLayer *usernameMaskLayer = [[CAShapeLayer alloc] init];
//usernameMaskLayer.frame = username.bounds;
//usernameMaskLayer.path = usernameMaskPathWithRadiusTop.CGPath;
//
//CAShapeLayer *passwordMaskLayer = [[CAShapeLayer alloc] init];
//passwordMaskLayer.frame = password.bounds;
//passwordMaskLayer.path = passwordMaskPathWithRadiusBottom.CGPath;
//
//
//[username setTextAlignment:NSTextAlignmentLeft];
//[username setClearButtonMode:UITextFieldViewModeWhileEditing];
//usernameLayer.shadowOpacity = 0.0;
//[usernameLayer setMask:usernameMaskLayer];
//
//[password setTextAlignment:NSTextAlignmentLeft];
//[username setClearButtonMode:UITextFieldViewModeWhileEditing];
//passwordLayer.shadowOpacity = 0.0;
//[passwordLayer setMask:passwordMaskLayer];
