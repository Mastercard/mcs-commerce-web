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

/// Private Struct - User
private struct userStruct {
    static let kUserId = "userId"
    static let kUsername = "username"
    static let kFirstName = "firstName"
    static let kLastName = "lastName"
}

/// User object, handles the user properties after login
class User: NSObject, NSCoding {
    //MARK: Variables
    
    /// User identifier
    var userId: String?
    
    /// User username, used in the login
    var username: String?
    
    /// User first name
    var firstName: String?
    
    /// User last name
    var lastName: String?
    
    /// Singleton instance
    static let sharedInstance : User = {
        if let instance = DataPersisterManager.sharedInstance.getUser() {
            return instance
        }
        return User()
    }()
    // MARK: Initializers
    // Private initializer
    private override init() {
        super.init()
    }
    
    // MARK: Methods
    /// Saves the user
    func saveUser(){
        DataPersisterManager.sharedInstance.saveUser()
    }
    
    /// Validates if the user is logged in or not
    ///
    /// - Returns: Boolean indicating if the user is logged in
    func isLoggedIn() -> Bool {
        return !(self.userId ?? "").isEmpty
    }
        
    /// Deletes all user properties
    func doLogout() {
        self.userId = nil
        self.username = nil
        self.firstName = nil
        self.lastName = nil
        self.saveUser()
    }
    
    //MARK: NSCoding
    
    /// NSCoding Initializer
    ///
    /// - Parameters:
    ///   - coder: NSCoder instance
    internal required init?(coder aDecoder: NSCoder) {
        self.userId = aDecoder.decodeObject(forKey: userStruct.kUserId) as? String
        self.username = aDecoder.decodeObject(forKey: userStruct.kUsername) as? String
        self.firstName = aDecoder.decodeObject(forKey: userStruct.kFirstName) as? String
        self.lastName = aDecoder.decodeObject(forKey: userStruct.kLastName) as? String
        super.init()
    }
    
    /// NSCoding Method
    ///
    /// - Parameter aCoder: NSCoder instance
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.userId, forKey:userStruct.kUserId)
        aCoder.encode(self.username, forKey:userStruct.kUsername)
        aCoder.encode(self.firstName, forKey:userStruct.kFirstName)
        aCoder.encode(self.lastName, forKey:userStruct.kLastName)
    }
}
