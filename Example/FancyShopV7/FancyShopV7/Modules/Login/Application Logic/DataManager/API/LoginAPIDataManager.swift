//
//  LoginAPIDataManager.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 11/01/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import Alamofire
/// LoginAPIDataManager implements the LoginAPIDataManagerInputProtocol protocol, if data needs to be saved/retrieved from the server, all the implentation should be done here
class LoginAPIDataManager: LoginAPIDataManagerInputProtocol {
    
    // MARK: Initializers
    /// Base initializer
    init() {}
    
    
    /// Makes an authentication against OneServer
    ///
    /// - Parameters:
    ///   - username: String with the username
    ///   - password: String with the password
    ///   - completionHandler: block of code to execute after OneServer response
    func doLogin(username: String, password: String, completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        let params: [String: Any] = [
            "username" : username,
            "password" : password
        ]
        
        Alamofire.request(OneServerRouter.login(params)).responseJSON { response in
            /*
             var responseDict: NSDictionary
             let responseKeys: [String] = ["status", "data"]
             switch response.result{
             case .success(let json):
             responseDict = NSDictionary.init(objects: [Constants.status.OK, json], forKeys: responseKeys as [NSCopying])
             completionHandler(responseDict, nil)
             case .failure(let error):
             responseDict = NSDictionary.init(objects: [Constants.status.NOK, NSNull()], forKeys: responseKeys as [NSCopying])
             completionHandler(responseDict, error)
             }*/
            
            /****************************************/
            //TODO: Mock SignIn response
            var responseDict: NSDictionary
            let responseKeys: [String] = ["status", "data"]
            
            //Create User id from username
            let data = username.data(using: .utf8)!
            let userID = data.map{ String(format:"%02x", $0) }.joined()
            
            let json : [String : String] = ["firstName" : "Jack", "lastName" : "Smith", "userId" : userID, "username" : username];
            responseDict = NSDictionary.init(objects: [Constants.status.OK, json], forKeys: responseKeys as [NSCopying])
            completionHandler(responseDict, nil)
            /****************************************/
        }
    }
}
