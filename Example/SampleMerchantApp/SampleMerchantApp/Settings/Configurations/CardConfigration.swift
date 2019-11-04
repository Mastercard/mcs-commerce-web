//
//  CardConfigration.swift
//  SampleMerchantApp
//
//  Created by Robinson, Marcus on 10/16/19.
//  Copyright © 2019 Robinson, Marcus. All rights reserved.
//

import Foundation

private struct CardConfigurationStruct {
    static let kIsSelected = "isSelected"
    static let kName = "name"
}

/// Card object used in the settings module
class CardConfiguration: NSObject, NSCoding {
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
    
    /// Returns the cardbrand code, based on the selected cardType
    ///
    /// - Returns: String cardbrand code
    func getcardBrandCode(cardtype  : Constants.cardsEnum) -> String {
        switch cardtype {
        case Constants.cardsEnum.MasterCard:
            return "master"
        case Constants.cardsEnum.VISA:
            return "visa"
        case Constants.cardsEnum.AmericanExpress:
            return "amex"
        }
    }
    
    //MARK: NSCoding
    
    /// NSCoding Initializer
    ///
    /// - Parameters:
    ///   - coder: NSCoder instance
    required init?(coder aDecoder: NSCoder) {
        if let name = Constants.cardsEnum(rawValue: aDecoder.decodeObject(forKey:CardConfigurationStruct.kName) as! String){
            self.name = name
            self.isSelected = aDecoder.decodeBool(forKey: CardConfigurationStruct.kIsSelected)
        }
    }
    
    /// NSCoding Method
    ///
    /// - Parameter aCoder: NSCoder instance
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name.rawValue, forKey:CardConfigurationStruct.kName)
        aCoder.encode(self.isSelected, forKey: CardConfigurationStruct.kIsSelected)
    }
}
