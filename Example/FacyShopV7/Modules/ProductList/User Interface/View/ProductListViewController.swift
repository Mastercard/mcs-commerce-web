//
//  ProductListView.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 09/26/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

/// Shows the product list in a collection view
class ProductListViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ProductListViewProtocol {
    
    
    // MARK: variables
    var presenter: ProductListPresenterProtocol?
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var shoppingCartButton: ShoppingCartButton!
    fileprivate var products: [Product] = []
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuViewHeight: NSLayoutConstraint!
    @IBOutlet weak var menuViewWidth: NSLayoutConstraint!
    @IBOutlet weak var settingsButton: UIButton!
    var isMenuHidden: Bool = true
    fileprivate let reuseIdentifier = "ProductCell"
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    fileprivate let collectionViewItemHeight: CGFloat = 200
    
    /// Static method will initialize the view
    ///
    /// - Returns: ProductListViewController instance to be presented
    static func instantiate() -> ProductListViewProtocol{
        return UIStoryboard(name: "ProductList", bundle: nil).instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
    }
    /// Overwritten method from UIVIewController, adds a shadow to the menú view
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuView.layer.masksToBounds =  true
        self.menuView.layer.shadowColor = UIColor.darkGray.cgColor;
        self.menuView.layer.shadowOffset = CGSize(width: 2.0,height: 2.0)
        self.menuView.layer.shadowOpacity = 1.0
        
//        //Start and stop animating because issue in NVActivityIndicatorView library
//        startAnimating()
//        stopAnimating()
    }
    
    /// Reloads the data into all widgets
    override func reloadData(){
        self.productCollectionView.reloadData()
        super.setupEmptyMessageIfNeeded(collectionView: self.productCollectionView, array: self.products, emptyMessage: "There are no products")
//        stopAnimating()
    }
    /// Overwritten method from UIVIewController, calls the presenter to get the required data
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if self.isMovingToParent{
//            startAnimating()
            self.navigationController?.isNavigationBarHidden = true;
            self.presenter?.fetchProducts();
        } else {
            self.reloadData()
        }
        self.hideMenu(animated: false)
        self.presenter?.configureShoppingCartButton()
    }
    
    /// Returns a product from the list using the given index
    ///
    /// - Parameter index: Index to get the product
    /// - Returns: a Product object
    fileprivate func getProductFromListUsingIndex(index: Int) -> Product{
        return self.products[index];
    }
    
    /// Ask the presenter to go to the settings module
    ///
    /// - Parameter sender: Any object
    @IBAction func settingsAction(_ sender: Any) {
        self.presenter?.settingsAction()
    }
    
    
    /// Tells the presenter to add a new product to the cart
    ///
    /// - Parameter sender: UIbutton instance
    @IBAction func addToShoppingCartAction(_ sender: UIButton) {
        let cell: ProductCell = sender.superview?.superview as! ProductCell
        if let indexPath: NSIndexPath = self.productCollectionView.indexPath(for: cell) as NSIndexPath? {
            self.presenter?.addProductToShoppingCart(product: self.getProductFromListUsingIndex(index: indexPath.row))
            super.animateView(view: self.shoppingCartButton, duration: 0.5)
        }
    }
    
    /// Ask the presenter to go to the order summary module
    ///
    /// - Parameter sender: Any object
    @IBAction func goToShoppingCartAction(_ sender: Any) {
        self.presenter?.goToConfirmOrderAction()
    }
    
    // MARK: - Menu Methods
    /// Used to show and hide the menu from the view
    ///
    /// - Parameter sender: Any object
    @IBAction func menuAction(_ sender: Any) {
        if self.isMenuHidden {
            self.showMenu(animated: true)
        }else{
            self.hideMenu(animated: true)
        }
    }
    
    /// Hides the menu
    ///
    /// - Parameter animated: Animation flag
    fileprivate func hideMenu(animated: Bool){
        self.menuView.layer.masksToBounds =  true
        self.isMenuHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.menuViewHeight.constant = 0
            if animated{
                self.view.layoutIfNeeded()
            }
        }, completion: nil)
    }
    
    /// Shows the menu
    ///
    /// - Parameter animated: Animation flag
    fileprivate func showMenu(animated: Bool){
        self.menuView.layer.masksToBounds =  false
        self.isMenuHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.menuViewHeight.constant = 160
            if animated{
                self.view.layoutIfNeeded()
            }
        }, completion: nil)
    }
    
    /// Ask the presenter to go to the login module
    ///
    /// - Parameter sender: Any object
    @IBAction func goToLoginAction(_ sender: Any) {
        self.presenter?.goToLogin()
    }
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCell
        let theProduct = self.getProductFromListUsingIndex(index: indexPath.row)
        
        cell.name.text = theProduct.name
        cell.salePrice.text = SDKConfiguration.sharedInstance.getCurrencySymbol() + String(format: "%.02f",theProduct.salePrice)
        cell.image.image =  UIImage.init(named: (theProduct.imagePath as NSString).lastPathComponent, in: nil, compatibleWith: nil)
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: collectionViewItemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }    
    // MARK: ProductListViewProtocol
    
    /// Stores the products and reloads the collection view
    ///
    /// - Parameter products: Product array
    func showProducts(products: [Product]) {
        self.products = products
        self.reloadData()
    }
    
    /// Shows an error in an alert
    ///
    /// - Parameter error: String with the error
    func showError(error: String) {
        super .showErrorInAlert(message: error)
    }
    
    /// Shows the number of product in the card on the button
    ///
    /// - Parameter quantity: Number of products
    func showQuantityOfProductsInCartButton(quantity: Int) {
        self.shoppingCartButton.setBadgeText(numberOfItems: quantity)
    }
}
