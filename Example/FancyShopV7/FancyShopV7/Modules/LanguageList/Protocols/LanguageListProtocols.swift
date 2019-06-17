//
//  LanguageListProtocols.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/13/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// Method contract between PRESENTER -> VIEW
protocol LanguageListViewProtocol: class {
    var presenter: LanguageListPresenterProtocol? { get set }
    func setCurrent(language: String)
}

/// Method contract between PRESENTER -> WIREFRAME
protocol LanguageListWireFrameProtocol: class {
    static func presentLanguageListModule(fromView view: AnyObject)
    func goBack(_ animated: Bool)
}

/// Method contract between VIEW -> PRESENTER
protocol LanguageListPresenterProtocol: class {
    var view: LanguageListViewProtocol? { get set }
    var interactor: LanguageListInteractorInputProtocol? { get set }
    var wireFrame: LanguageListWireFrameProtocol? { get set }
    
    func getCurrentLanguage()
    func goBack(_ animated: Bool)
    func languageSelected(language: String)
}

/// Method contract between INTERACTOR -> PRESENTER
protocol LanguageListInteractorOutputProtocol: class {
    func setCurrent(language: String)
}

/// Method contract between PRESENTER -> INTERACTOR
protocol LanguageListInteractorInputProtocol: class
{
    var presenter: LanguageListInteractorOutputProtocol? { get set }
    var APIDataManager: LanguageListAPIDataManagerInputProtocol? { get set }
    var localDatamanager: LanguageListLocalDataManagerInputProtocol? { get set }
    func getCurrentLanguage()
    func languageSelected(language: String)
}

/// Method contract between INTERACTOR -> DATAMANAGER
protocol LanguageListDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> APIDATAMANAGER
protocol LanguageListAPIDataManagerInputProtocol: class{
}

/// Method contract between INTERACTOR -> LOCALDATAMANAGER
protocol LanguageListLocalDataManagerInputProtocol: class{
}
