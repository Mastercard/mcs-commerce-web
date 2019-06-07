//
//  DoubleExtension.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/9/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
extension Double {
    
    /// Rounds the double to decimal places value
    ///
    /// - Parameter fractionDigits: Numbers of digits
    /// - Returns: A double with the decimals needed
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
