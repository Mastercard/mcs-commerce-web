//
//  AllowedDSRPListPresenter.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Presenter that acts between the interactor and the view, handles view events and interactor outputs
class AllowedDSRPListPresenter:BasePresenter, AllowedDSRPListPresenterProtocol, AllowedDSRPListInteractorOutputProtocol {
    
    // MARK: Variables
    
    /// AllowedDSRPListViewProtocol optional variable
    weak var view: AllowedDSRPListViewProtocol?
    /// AllowedDSRPListInteractorInputProtocol optional variable
    var interactor: AllowedDSRPListInteractorInputProtocol?
    /// AllowedDSRPListWireFrameProtocol optional variable
    var wireFrame: AllowedDSRPListWireFrameProtocol?
    
    // MARK: AllowedDSRPListPresenterProtocol methods
    
    
    /// Tells the wireframe to go back
    ///
    /// - Parameter animated: animation flag
    func goBack(animated: Bool) {
        self.wireFrame?.goBack(animated: animated)
    }
    
    /// Tells the interactor to fetch the tokenization options
    func fetchDSRPList() {
        self.interactor?.fetchDSRPList()
    }
    
    /// Tells the interactor to save the new preferences
    ///
    /// - Parameter dsrps: DSRP array
    func dsrpSelectedAction(dsrps: [DSRP]) {
        self.interactor?.dsrpSelected(dsrps: dsrps)
    }
    // MARK: AllowedDSRPListInteractorOutputProtocol methods
    func setDSRPList(dsrps: [DSRP]) {
        self.view?.setDSRPList(dsrps: dsrps)
    }
}
