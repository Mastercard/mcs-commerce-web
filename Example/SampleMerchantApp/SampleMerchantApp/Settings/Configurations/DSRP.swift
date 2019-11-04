//
//  DSRP.swift
//  SampleMerchantApp
//
//  Created by Robinson, Marcus on 10/17/19.
//  Copyright © 2019 Robinson, Marcus. All rights reserved.
//

import Foundation

/// Private Struct - CardConfiguration
private struct DSRPStruct {
    static let kIsSelected = "isSelected"
    static let kName = "name"
}

/// Tokenization object used in the settings module
class DSRP: NSObject, NSCoding {
    
    
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
        if let name = Constants.DSRPEnum(rawValue: aDecoder.decodeObject(forKey:DSRPStruct.kName) as! String){
            self.name = name
            self.isSelected = aDecoder.decodeBool(forKey: DSRPStruct.kIsSelected)
        }
    }
    
    /// NSCoding Method
    ///
    /// - Parameter aCoder: NSCoder instance
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name.rawValue, forKey:DSRPStruct.kName)
        aCoder.encode(self.isSelected, forKey: DSRPStruct.kIsSelected)
    }
    
}
