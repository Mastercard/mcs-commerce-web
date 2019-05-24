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

/// BuildConfiguration handles the configuration taken from a Plist, that plist is loaded depending of the selected scheme
class BuildConfiguration: NSObject {
    // MARK: Variables
    
    /// Singleton instance
    static let sharedInstance = BuildConfiguration()
    
    /// Configuration taken from the plist
    var configs: NSDictionary!
    
    //MARK: Initializers
    
    /// Base initializer, loads the corresponding Plist to the configs var
    override init() {
        //  let test = EnvironmentConfiguration.sharedInstance
        // let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Config") as! String
        //        let path = Bundle.main.path(forResource: currentConfiguration, ofType: "plist")!
        //        configs = NSDictionary(contentsOfFile: path)
    }
}

// MARK: - BuildConfiguration Extension
extension BuildConfiguration {
    
    /// Returns the environment name
    ///
    /// - Returns: String environment name
    func environmentName() -> String {
        return ""
    }
    
    
    /// Returns the merchant Url scheme
    ///
    /// - Returns: String merchant Url scheme
    func merchantUrlScheme() -> String {
        return ""
    }
    
    
    /// Returns the server runtime url
    ///
    /// - Returns: String runtime server url
    func runtime() -> String {
        return EnvironmentConfiguration.sharedInstance.checkoutHost
    }
    
    /// Returns the API version
    ///
    /// - Returns: String API version
    func API() -> String {
        return "/api/java"
    }
    
    
    /// Returns the checkout id for the current scheme
    ///
    /// - Returns: String with the checkout id
    func checkoutId() -> String {
        return EnvironmentConfiguration.sharedInstance.checkoutID
    }
}
