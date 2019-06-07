//
//  DSRP.swift
//  Merchant Checkout App
//
//  Created by MasterCard on 10/20/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Tokenization object used in the settings module
class DSRP: NSObject, NSCoding{
    
    
    /// Tokenization name
    var name: Constants.DSRPEnum = Constants.DSRPEnum.ICC
    
    /// Tokenization status
    var isSelected: Bool = false
    
    // MARK: Initializers
    /// Initializer that takes a tokenization as a parameter
    ///
    /// - Parameter withName: DSRPEnum, Tokenization name
    init(withName: Constants.DSRPEnum) {
        self.name = withName
        isSelected = true
    }
    
    //MARK: NSCoding
    
    /// NSCoding Initializer
    ///
    /// - Parameters:
    ///   - coder: NSCoder instance
    required init?(coder aDecoder: NSCoder) {
        if let name = Constants.DSRPEnum(rawValue: aDecoder.decodeObject(forKey:"name") as! String){
            self.name = name
            self.isSelected = aDecoder.decodeBool(forKey: "isSelected")
        }
    }
    
    /// NSCoding Method
    ///
    /// - Parameter aCoder: NSCoder instance
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name.rawValue, forKey:"name")
        aCoder.encode(self.isSelected, forKey: "isSelected")
    }
    
}
