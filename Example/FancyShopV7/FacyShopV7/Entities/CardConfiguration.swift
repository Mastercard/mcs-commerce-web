//
//  Card.swift
//  Merchant Checkout App
//
//  Created by MasterCard on 10/12/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Card object used in the settings module
class CardConfiguration: NSObject, NSCoding{
    //MARK: Variables
    /// Card name
    var name: Constants.cardsEnum = Constants.cardsEnum.MasterCard
    
    /// Card status
    var isSelected: Bool = false
    
    /// Card image
    var image: String {
        return "card" + self.name.rawValue
    }
    
    // MARK: Initializers
    
    /// Initializer
    ///
    /// - Parameter withName: cardsEnum
    init(withName: Constants.cardsEnum) {
        self.name = withName
        isSelected = true
    }
    
    
    //MARK: NSCoding
    
    /// NSCoding Initializer
    ///
    /// - Parameters:
    ///   - coder: NSCoder instance
    required init?(coder aDecoder: NSCoder) {
        if let name = Constants.cardsEnum(rawValue: aDecoder.decodeObject(forKey:"name") as! String){
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
