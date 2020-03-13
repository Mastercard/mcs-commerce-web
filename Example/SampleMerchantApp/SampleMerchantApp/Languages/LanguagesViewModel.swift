//
//  LanguagesViewModel.swift
//  SampleMerchantApp
//
//  Created by Robinson, Marcus on 10/22/19.
//  Copyright © 2019 Robinson, Marcus. All rights reserved.
//

import Foundation

class LanguagesViewModel {
    
    /// Fetches the Languages list from local
    ///
    /// - Parameter completionHandler: Block of code that will be executed after the request for shipping options
    func fetchLanguages(completionHandler: @escaping ([LanguageConfiguration]?, Error?) -> ()) {
        
        var languages: [LanguageConfiguration] = [LanguageConfiguration]()
        
        let url = Bundle.main.path(forResource: "language", ofType: "json")
        let data = NSData(contentsOfFile: url!)
        if data != nil {
            
            do {
                let languagesJSON = try JSONSerialization.jsonObject(with: data! as Data, options: []) as? [NSDictionary]
                
                for languageJSON_: NSDictionary in languagesJSON! {
                    let language: LanguageConfiguration = LanguageConfiguration.init()
                    language.language = languageJSON_.value(forKey: "language") as! String
                    language.countryCode = languageJSON_.value(forKey: "countryCode") as! String
                    language.currencyCode = languageJSON_.value(forKey: "currencyCode") as! String
                    language.currencySymbol = languageJSON_.value(forKey: "currencySymbol") as! String
                    language.locale = languageJSON_.value(forKey: "locale") as! String
                    languages.append(language)
                }
                
                completionHandler(languages,nil);
            } catch let error as NSError {
                
                completionHandler(nil,error);
            }
        } else {
            
            completionHandler(nil,nil);
        }
    }
}
