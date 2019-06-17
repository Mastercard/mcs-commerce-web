//
//  Router.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/11/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

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
    case getPairingId([String: Any])
    case preCheckoutData([String: Any])
    case doExpressCheckout([String: Any])
    
    
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
        case .getPairingId:
            return .post
        case .preCheckoutData:
            return .post
        case .doExpressCheckout:
            return .post
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
        case .getPairingId:
            return Constants.APIRoutes.getPairingId
        case .preCheckoutData:
            return Constants.APIRoutes.preCheckoutData
        case .doExpressCheckout:
            return Constants.APIRoutes.expressCheckout
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
            case .getPairingId(let params):
                return (params)
            case .preCheckoutData(let params):
                return (params)
            case .doExpressCheckout(let params):
                return (params)
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
