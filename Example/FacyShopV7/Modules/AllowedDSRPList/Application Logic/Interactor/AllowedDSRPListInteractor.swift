//
//  AllowedDSRPListInteractor.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// AllowedDSRPListInteractor implements AllowedDSRPListInteractorInputProtocol protocol, handles the interaction to save and change the tokenization values
class AllowedDSRPListInteractor: AllowedDSRPListInteractorInputProtocol {
    
    // MARK: Variables
    
    /// AllowedDSRPListInteractorOutputProtocol optional instance
    weak var presenter: AllowedDSRPListInteractorOutputProtocol?
    
    /// AllowedDSRPListAPIDataManagerInputProtocol optional instance
    var APIDataManager: AllowedDSRPListAPIDataManagerInputProtocol?
    
    /// AllowedDSRPListLocalDataManagerInputProtocol optional instance
    var localDatamanager: AllowedDSRPListLocalDataManagerInputProtocol?
    
    // MARK: Initializers
    
    /// Class default initializer
    init() {}
    
    
    // MARK: AllowedDSRPListInteractorInputProtocol Methods
    
    
    /// Fetchs the saved tokenizations and pass them to the presenter
    func fetchDSRPList() {
        self.presenter?.setDSRPList(dsrps: SDKConfiguration.sharedInstance.DSRPs)
    }
    
    
    /// Saves the new preferences about tokenization
    ///
    /// - Parameter dsrps: DSRP array
    func dsrpSelected(dsrps: [DSRP]) {
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        configuration.DSRPs = dsrps
        configuration.saveConfiguration()
    }
}
