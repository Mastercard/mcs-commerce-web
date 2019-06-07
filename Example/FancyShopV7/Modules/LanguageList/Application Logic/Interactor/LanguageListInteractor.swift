//
//  LanguageListInteractor.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/13/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation

/// LanguageListInteractor implements LanguageListInteractorInputProtocol protocol, handles the interaction to save and change the tokenization values
class LanguageListInteractor: LanguageListInteractorInputProtocol {
    
    // MARK: Variables
    weak var presenter: LanguageListInteractorOutputProtocol?
    var APIDataManager: LanguageListAPIDataManagerInputProtocol?
    var localDatamanager: LanguageListLocalDataManagerInputProtocol?
    
    // MARK: Initializers
    
    /// Class default initializer
    init() {}
    
    // MARK: LanguageListInteractorInputProtocol
    
    /// Gets the current language and pass it to the presenter
    func getCurrentLanguage() {
        let config: SDKConfiguration = SDKConfiguration.sharedInstance
        self.presenter?.setCurrent(language: config.language)
    }
    
    /// Saves the selected language in the configuration
    ///
    /// - Parameter language: Enum with the selected language
    func languageSelected(language: String) {
        SDKConfiguration.sharedInstance.setLanguage(language: language)
    }
}
