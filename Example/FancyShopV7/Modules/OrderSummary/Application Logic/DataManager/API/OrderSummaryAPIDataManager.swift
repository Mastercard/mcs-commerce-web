//
//  OrderSummaryAPIDataManager.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/08/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import Alamofire
import MerchantServices
/// OrderSummaryAPIDataManager implements the OrderSummaryAPIDataManagerInputProtocol protocol, if data needs to be saved/retrieved from the server, all the implentation should be done here
class OrderSummaryAPIDataManager: OrderSummaryAPIDataManagerInputProtocol {
    // MARK: Initializers
    
    /// Base initializer
    init() {}
    
    
    /// Gets the pairing Id from OneServer
    ///
    /// - Parameter completionHandler: Block of code that will be executed after the request is done
    func getPairingId(completionHandler: @escaping (NSDictionary?, Error?) -> ()){
        let user: User = User.sharedInstance
        
        let paringIDService = MDSMerchantServices()
        let paringIDRequest = MDSPairingIDServiceRequest()
        paringIDRequest.pairingTransactionId = user.pairingTransactionId as! String
        paringIDRequest.merechantKeyFileName = EnvironmentConfiguration.sharedInstance.merchankKeyFileName
        paringIDRequest.merechantKeyFilePassword = EnvironmentConfiguration.sharedInstance.merchankKeyFilePwd
        paringIDRequest.consumerKey = EnvironmentConfiguration.sharedInstance.consumerKey
        paringIDRequest.host = EnvironmentConfiguration.sharedInstance.switchHost
        paringIDRequest.userId = user.userId as! String
        
        var responseDict = NSDictionary()
        let responseKeys: [String] = ["status", "data"]
        paringIDService.getPairingIDService(paringIDRequest, onSuccess: { responseObject in
            let dataDict:NSDictionary = responseObject! as NSDictionary
            responseDict = NSDictionary.init(objects: [Constants.status.OK, dataDict], forKeys: responseKeys as [NSCopying])
            completionHandler(responseDict, nil)
        }) { err in
            responseDict = NSDictionary.init(objects: [Constants.status.NOK, ""], forKeys: responseKeys as [NSCopying])
            completionHandler(responseDict, err)
        }
    }
}

