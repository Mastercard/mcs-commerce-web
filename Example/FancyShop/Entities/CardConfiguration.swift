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

/// Private Struct - CardConfiguration
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
        case Constants.cardsEnum.Discover,
            Constants.cardsEnum.DinersClub,
            Constants.cardsEnum.Maestro:
            return ""
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
