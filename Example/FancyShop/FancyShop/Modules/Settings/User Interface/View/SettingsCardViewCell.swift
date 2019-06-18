/* Copyright © 2019 Mastercard. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 =============================================================================*/

import Foundation

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
