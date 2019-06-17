//
//  SettingsCardViewCell.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 10/17/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

/// Card view cell used in the settings list
class SettingsCardViewCell: UITableViewCell {
    @IBOutlet weak var card1: UIImageView!
    @IBOutlet weak var card2: UIImageView!
    @IBOutlet weak var card3: UIImageView!
    @IBOutlet weak var card4: UIImageView!
    @IBOutlet weak var card5: UIImageView!
    @IBOutlet weak var card6: UIImageView!
    
    func setupCards(cards: [CardConfiguration]){
        self.card1?.isHidden = true
        self.card2?.isHidden = true
        self.card3?.isHidden = true
        self.card4?.isHidden = true
        self.card5?.isHidden = true
        self.card6?.isHidden = true
        let cardImagesArray:[UIImageView] = [self.card1, self.card2, self.card3, self.card4, self.card5, self.card6]
        
        var cardsIndex = 0
        var imagesIndex = 0
        repeat {
            if cards[cardsIndex].isSelected{
                cardImagesArray[imagesIndex].image = UIImage(named: cards[cardsIndex].image)
                cardImagesArray[imagesIndex].isHidden = false
                imagesIndex = imagesIndex + 1
            }
            cardsIndex = cardsIndex + 1
        } while cardsIndex < cards.count
    }
}
