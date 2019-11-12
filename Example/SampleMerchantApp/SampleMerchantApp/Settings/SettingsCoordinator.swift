//
//  SettingsCoordinator.swift
//  SampleMerchantApp
//
//  Created by Robinson, Marcus on 10/22/19.
//  Copyright © 2019 Robinson, Marcus. All rights reserved.
//

import Foundation
import UIKit

class SettingsCoordinator {
    let navigationHelper: NavigationHelper = NavigationHelper.sharedInstance
    let manager: SRCSDKManager = SRCSDKManager()
    
    func cardsAllowedOptionSelected() {
        let cardListViewController: AllowedCardListViewController = AllowedCardListViewController.instantiate() as! AllowedCardListViewController
        navigationHelper.pushViewController(viewController: cardListViewController, animated: true)
        
    }
    
    func languagesOptionSelected() {
        let languagesViewController: LanguageListViewController = LanguageListViewController.instantiate() as! LanguageListViewController
        navigationHelper.pushViewController(viewController: languagesViewController, animated: true)
    }
    
    func currenciesOptionSelected() {
        let currencyViewController: CurrencyListViewController = CurrencyListViewController.instantiate() as! CurrencyListViewController
        navigationHelper.pushViewController(viewController: currencyViewController, animated: true)
    }

    func DSRPAllowedOptionSelected() {
        let dsrpViewController: AllowedDSRPListViewController = AllowedDSRPListViewController.instantiate() as! AllowedDSRPListViewController
        navigationHelper.pushViewController(viewController: dsrpViewController, animated: true)
    }
}
