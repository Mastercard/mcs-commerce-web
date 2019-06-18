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

class URLbuilder : NSObject {
    
    class func getURLQueryParamsFromDictionary(urlString:String,params : Dictionary<String,Any>) -> String {
        
        let queryItems = params.map({ URLQueryItem(name: $0.key, value: ($0.value as! String)) })
        var urlComps = URLComponents(string: urlString)
        urlComps?.queryItems = queryItems
        return urlComps?.url?.absoluteString ?? ""
    }
    
    class func getAPIBaseurl(baseURL:String,urlpath:String) -> String {
        return baseURL + urlpath
    }
}

