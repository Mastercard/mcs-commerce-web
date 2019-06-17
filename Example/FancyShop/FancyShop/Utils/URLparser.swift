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

/// URLparser extract url components from query param url.
class URLparser : NSObject {
    
    /// Parse query param url and return params dictionary
    ///
    /// - Returns: NSDictionary url params.
    func parseURLQueryParamToDictionary (url:URL) -> NSDictionary {
        let parseData = NSMutableDictionary()
        let queryItems = URLComponents(string: url.absoluteString)?.queryItems
        
        if queryItems != nil {
        for queryItem in queryItems! {
            parseData.setValue(queryItem.value, forKey: queryItem.name)
          }
        }
        return parseData
    }
}
