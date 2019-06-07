//
//  AllowedDSRPListProtocols.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/16/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// Method contract between PRESENTER -> VIEW
protocol AllowedDSRPListViewProtocol: class {
    var presenter: AllowedDSRPListPresenterProtocol? { get set }
    func setDSRPList(dsrps: [DSRP])
}


/// Method contract between PRESENTER -> WIREFRAME
protocol AllowedDSRPListWireFrameProtocol: class {
    static func presentAllowedDSRPListModule(fromView view: AnyObject)
    func goBack(animated: Bool)
}

/// Method contract between VIEW -> PRESENTER
protocol AllowedDSRPListPresenterProtocol: class {
    var view: AllowedDSRPListViewProtocol? { get set }
    var interactor: AllowedDSRPListInteractorInputProtocol? { get set }
    var wireFrame: AllowedDSRPListWireFrameProtocol? { get set }
    
    func fetchDSRPList()
    func goBack(animated: Bool)
    func dsrpSelectedAction(dsrps: [DSRP])
}

/// Method contract between INTERACTOR -> PRESENTER
protocol AllowedDSRPListInteractorOutputProtocol: class {
    func setDSRPList(dsrps: [DSRP])
}


/// Method contract between PRESENTER -> INTERACTOR
protocol AllowedDSRPListInteractorInputProtocol: class{
    var presenter: AllowedDSRPListInteractorOutputProtocol? { get set }
    var APIDataManager: AllowedDSRPListAPIDataManagerInputProtocol? { get set }
    var localDatamanager: AllowedDSRPListLocalDataManagerInputProtocol? { get set }
    
    func fetchDSRPList()
    func dsrpSelected(dsrps: [DSRP])
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol AllowedDSRPListDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol AllowedDSRPListAPIDataManagerInputProtocol: class{
}

/// Method contract between communication INTERACTOR -> LOCALDATAMANAGER
protocol AllowedDSRPListLocalDataManagerInputProtocol: class{
}
