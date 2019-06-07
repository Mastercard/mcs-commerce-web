//
//  ProductCell.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 9/30/17.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import UIKit

/// Product cell for the collection view
class ProductCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var salePrice: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
}
