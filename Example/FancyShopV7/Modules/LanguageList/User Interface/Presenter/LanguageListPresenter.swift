//
//  LanguageListPresenter.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/13/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
/// Presenter that acts between the interactor and the view, handles view events and interactor outputs
class LanguageListPresenter: LanguageListPresenterProtocol, LanguageListInteractorOutputProtocol {
    
    // MARK: Variables
    weak var view: LanguageListViewProtocol?
    var interactor: LanguageListInteractorInputProtocol?
    var wireFrame: LanguageListWireFrameProtocol?
    
    // MARK: Initializers
    /// Base initializer
    init() {}
    
    //MARK: LanguageListPresenterProtocol
    
    /// Ask for the current language
    func getCurrentLanguage() {
        self.interactor?.getCurrentLanguage()
    }
    
    /// Goes back to the previous screen
    ///
    /// - Parameter animated: animation flag
    func goBack(_ animated: Bool) {
        self.wireFrame?.goBack(animated)
    }
    
    /// Tells the interactor that a language has been selected
    ///
    /// - Parameter currency: Enum with the language
    func languageSelected(language: String) {
        self.interactor?.languageSelected(language: language)
    }
    
    //MARK: LanguageListInteractorOutputProtocol
    
    /// Sets the current language to the view
    ///
    /// - Parameter language: Enum with the current language
    func setCurrent(language: String) {
        self.view?.setCurrent(language: language)
    }
}
