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
private struct DSRPStruct {
    static let kIsSelected = "isSelected"
    static let kName = "name"
}

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
