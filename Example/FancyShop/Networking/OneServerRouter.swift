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

import Alamofire

/// Routing for OneServer to get the requests configured for what ever is needed
enum OneServerRouter: URLRequestConvertible {
    // MARK: Variables
    /// Base url for the requests
    static let baseURLString = Constants.server.baseURL
    
    
    case getProducts
    case getPaymentData([String: Any])
    case postback([String: Any])
    case login([String: Any])
    
    /// HTTP method based on the request
    var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        case .getPaymentData:
            return .post
        case .postback:
            return .post
        case .login:
            return .get
        }
    }
    /// Path based on the request
    var path: String {
        switch self {
        case .getProducts:
            return Constants.APIRoutes.getProducts
        case .getPaymentData:
            return Constants.APIRoutes.getPaymentData
        case .postback:
            return Constants.APIRoutes.postback
        case .login:
            return Constants.APIRoutes.login
        }
    }
    
    // MARK: URLRequestConvertible
    
    /// Returns a URLRequest configured for the necessary request
    ///
    /// - Returns: Configured URLRequest
    /// - Throws: Exception
    func asURLRequest() throws -> URLRequest {
        let url = try OneServerRouter.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        let parameters: ([String: Any]?) = {
            switch self {
            case .getProducts:
                return (nil)
            case .getPaymentData(let params):
                return (params)
            case .postback(let params):
                return (params)
            case .login(let params):
                return params
            }
        }()
        
        switch self {
        case .login:
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        
    }
}
