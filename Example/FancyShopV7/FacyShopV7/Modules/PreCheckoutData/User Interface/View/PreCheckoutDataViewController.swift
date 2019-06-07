//
//  PreCheckoutDataView.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 11/07/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

/// Shows the cards and shipping addresses that can be used to do the checkout
class PreCheckoutDataViewController: BaseViewController, PreCheckoutDataViewProtocol, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    /// MARK: Variables
    var presenter: PreCheckoutDataPresenterProtocol?
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cardPageControl: UIPageControl!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var shippingCollectionView: UICollectionView!
    @IBOutlet weak var shippingPageControl: UIPageControl!
    var cards: [Card] = []
    var shippingAddress: [ShippingAddress] = []
    var currentCard: Card?
    var currentShippingAddress: ShippingAddress?
    
    /// Static method will initialize the view
    ///
    /// - Returns: PreCheckoutDataViewController instance to be presented
    static func instantiate() -> PreCheckoutDataViewController{
        return UIStoryboard(name: "PreCheckoutData", bundle: nil).instantiateViewController(withIdentifier: "PreCheckoutDataViewController") as! PreCheckoutDataViewController
    }
    
    /// Overwritten method from UIVIewController, calls the presenter to get the required data
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.isMovingToParent {
            self.presenter?.fetchData()
            self.shippingCollectionView.isHidden = SDKConfiguration.sharedInstance.suppressShipping
            self.shippingPageControl.isHidden = SDKConfiguration.sharedInstance.suppressShipping
        }
    }
    
    /// Overwritten method from UIVIewController, adjust the constraints as required
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftConstraint = NSLayoutConstraint(item: self.contentView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0);
        self.view.addConstraint(leftConstraint);
        let rightConstraint = NSLayoutConstraint(item: self.contentView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0);
        self.view.addConstraint(rightConstraint);
    }
    
    /// Ask the presenter to go back to the previous screen
    ///
    /// - Parameter sender: Any object
    @IBAction func goBack(_ sender: Any) {
        self.presenter?.goBack()
    }
    
    /// Sets the card information according with the selected one
    ///
    /// - Parameter forIndex: index of the selected card
    func setCardInfo(forIndex: Int){
        self.currentCard = self.cards[forIndex]
        self.cardNumberLabel.text = self.currentCard?.getSecretCardNumber()
    }
    
    /// Sets the shipping address information according with the selected one
    ///
    /// - Parameter forIndex: index of the shipping address
    func setShippingAddressInfo(forIndex: Int){
        self.currentShippingAddress = self.shippingAddress[forIndex]
    }
    
    /// Calls the presenter to make the express checkout
    ///
    /// - Parameter sender: Any object
    @IBAction func expressCheckoutAction(_ sender: Any) {
        
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        if let currentCard = self.currentCard {
            if (configuration.suppressShipping) {
                self.presenter?.expressCheckoutAction(card: currentCard, shippingAddress:nil,suppressShipping:true)
            } else {
                if let shippingAddress = self.currentShippingAddress {
                    self.presenter?.expressCheckoutAction(card: currentCard, shippingAddress:shippingAddress,suppressShipping:false)
                } else {
                    self.presenter?.expressCheckoutAction(card: currentCard, shippingAddress:nil,suppressShipping:true)
                }
            }
        }
    }
    
    // MARK: PreCheckoutDataViewProtocol
    
    /// Shows a spinner
    func startAnimating() {
//        super.startAnimating()
    }
    /// Dismisses the spinner
    func stopAnimating() {
//        super.stopAnimating()
    }
    
    /// Shows an error in an alert
    ///
    /// - Parameter message: String with the message
    func showError(message: String) {
        super.showErrorInAlert(message: message, title: "") { (void) in
            self.presenter?.goBack()
        }
    }
    
    /// Reloads the data in the widgets
    ///
    /// - Parameters:
    ///   - cards: Cards array
    ///   - addresses: Shipping addresses array
    func reloadData(cards: [Card], addresses: [ShippingAddress]) {
        self.cards = cards
        self.shippingAddress = addresses
        self.cardPageControl.numberOfPages = self.cards.count
        self.shippingPageControl.numberOfPages = self.shippingAddress.count
        self.cardCollectionView.reloadData()
        self.shippingCollectionView.reloadData()
        if self.cards.count > 0 {
            self.setCardInfo(forIndex: 0)
        }
        if self.shippingAddress.count > 0 {
            self.setShippingAddressInfo(forIndex: 0)
        }
    }
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.cardCollectionView {
            return self.cards.count
        }
        return self.shippingAddress.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.cardCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionCell", for: indexPath) as! CardCollectionCell
            let card = self.cards[indexPath.row]
            cell.brandNameLabel.text = card.brandName
            cell.cardNumberLabel.text = card.getSecretCardNumber()
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShippingCollectionCell", for: indexPath) as! ShippingCollectionCell
            let shippingAddress = self.shippingAddress[indexPath.row]
            cell.shippingAddressLabel.text = shippingAddress.getFullAddress(withBreakLines: true)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    //MARK: UICollectionViewDelegateFlowLayout
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex:Int = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        if scrollView == self.cardCollectionView{
            self.cardPageControl.currentPage = currentIndex
            self.setCardInfo(forIndex: currentIndex)
        } else{
            self.shippingPageControl.currentPage = currentIndex
            self.setShippingAddressInfo(forIndex: currentIndex)
        }
    }
}
