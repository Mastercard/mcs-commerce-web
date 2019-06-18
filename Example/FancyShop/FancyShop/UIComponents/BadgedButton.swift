/* Copyright © 2019 Mastercard. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 =============================================================================*/

import Foundation
import UIKit

/// Button that is used to show a badge with a text on it
class BadgedButton: UIButton {
    var badge: UILabel!
    var _badgeBorderColor : UIColor!
    var _badgeBgColor : UIColor!
    var _badgeTextColor : UIColor!
    
    @IBInspectable
    var badgeBorderColor: UIColor {
        get {
            return _badgeBorderColor
        }
        set {
            _badgeBorderColor = newValue
            self.badge.layer.borderColor = _badgeBorderColor.cgColor
        }
    }
    @IBInspectable
    var badgeBgColor: UIColor {
        get {
            return _badgeBgColor
        }
        set {
            _badgeBgColor = newValue
            self.badge.backgroundColor = _badgeBgColor
        }
    }
    @IBInspectable
    var badgeTextColor: UIColor{
        get {
            return _badgeTextColor
        }
        set {
            _badgeTextColor = newValue
            self.badge.textColor = _badgeTextColor
        }
    }
    
    @IBInspectable
    var  badgePosX: CGFloat = 0
    @IBInspectable
    var badgePosY: CGFloat = 0
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        
        self.badge = UILabel(frame: CGRect(x:0, y:0, width:21,height:21))
        
        self.badge.font = UIFont(name: "Helvetica", size: 12.0)
        self.badge.textAlignment = NSTextAlignment.center
        self.badgePosX = 0
        self.badgePosY = 0
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
