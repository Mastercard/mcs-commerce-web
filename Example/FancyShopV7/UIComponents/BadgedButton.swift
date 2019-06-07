//
//  UIButton+Badge.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/7/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

/// Button that is used to show a badge with a text on it
class BadgedButton: UIButton {
    var badge: UILabel
    @IBInspectable
    var badgeBorderColor: UIColor {
        get {
            return self.badgeBorderColor
        }
        set {
            self.badge.layer.borderColor = newValue.cgColor
        }
    }
    @IBInspectable
    var badgeBgColor: UIColor {
        get {
            return self.badgeBgColor
        }
        set {
            self.badge.backgroundColor = newValue
        }
    }
    @IBInspectable
    var badgeTextColor: UIColor{
        get {
            return self.badgeTextColor
        }
        set {
            self.badge.textColor = newValue
        }
    }
    
    @IBInspectable
    var  badgePosX: CGFloat
    @IBInspectable
    var badgePosY: CGFloat
    
    required init?(coder aDecoder: NSCoder) {
        self.badge = UILabel(frame: CGRect(x:0, y:0, width:21,height:21))
        
        self.badge.font = UIFont(name: "Avenir-Medium", size: 12.0)
        self.badge.textAlignment = NSTextAlignment.center
        self.badgePosX = 0
        self.badgePosY = 0
        super.init(coder: aDecoder)
        self.badgeBorderColor = UIColor.white
        self.badgeBgColor = UIColor.yellow
        self.badgeTextColor = UIColor.black
        self.badge.text = "12"
        
        self.badge.layer.cornerRadius = self.badge.frame.size.height/2;
        self.badge.layer.masksToBounds = true;
        
        self.addSubview(self.badge)
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        var frame: CGRect = self.badge.frame
        frame.origin.x = (self.imageView?.frame.origin.x)! + self.badgePosX;
        frame.origin.y = (self.imageView?.frame.origin.y)! + self.badgePosY;
        self.badge.frame = frame;
    }
}
