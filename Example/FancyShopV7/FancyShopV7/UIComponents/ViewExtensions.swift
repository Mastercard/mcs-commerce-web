//
//  ViewExtensions.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/26/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Extension to add Inspectable attributes to the views
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
