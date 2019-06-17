//
//  LoginView.swift
//  MerchantCheckoutApp
//
//  Created by MasterCard on 11/01/2017.
//  Copyright © 2018 MasterCard. All rights reserved.
//

import Foundation
import UIKit

/// Login view controller handles the login view, where the user types his username and password
class LoginViewController: BaseViewController, LoginViewProtocol {
    
    
    /// MARK: Variables
    var presenter: LoginPresenterProtocol?
    var isUserAlreadyLoggedIn : Bool = false
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var viewLoggedIn: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var paymentMethodBtn: UIButton!
    
    /// Static method will initialize the view
    ///
    /// - Returns: LoginViewController instance to be presented
    static func instantiate() -> LoginViewProtocol{
        return UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    /// Overwritten method from UIVIewController, it calls a method to subscribe to keyboard events
    ///
    /// - Parameter animated: animation flag
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications()
        self.presenter?.checkLogin();
    }
    
    /// Overwritten method from UIVIewController, it calls a method to un-subscribe to keyboard events
    ///
    /// - Parameter animated: animation flag
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.deregisterForKeyboardNotifications()
    }
    
    /// Overwritten method from UIVIewController, It adds the 'down' gesture to dismiss the view
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer.init(target: self, action:#selector(LoginViewController.didSwipe))
        gesture.direction = .down
        self.view.addGestureRecognizer(gesture)
        self.passwordTextField.delegate = self
        let configuration: SDKConfiguration = SDKConfiguration.sharedInstance
        let user: User = User.sharedInstance
        if (user.isLoggedIn()){
            if (configuration.enablePaymentMethodCheckout) {
                self.paymentMethodBtn.isUserInteractionEnabled = true
                self.paymentMethodBtn.alpha = 1.0
            }
            else{
                self.paymentMethodBtn.isUserInteractionEnabled = false
                self.paymentMethodBtn.alpha = 0.4
            }
        }
        else {
            self.paymentMethodBtn.isUserInteractionEnabled = false
            self.paymentMethodBtn.alpha = 0.0
        }
    }
    
    /// It will dismiss the view
    @objc
    func didSwipe(){
        self.presenter?.goBack(animated: true)
    }
    
    
    /// Overwrites the StatusBarStyle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// Login action called from the view
    ///
    /// - Parameter sender: Any object
    @IBAction func loginAction(_ sender: Any) {
        if (self.isUserAlreadyLoggedIn) {
            self.presenter?.doLogout()
            self.paymentMethodBtn.isEnabled = false
            self.paymentMethodBtn.alpha = 0.0
        } else {
            startAnimating()
            let username: String = self.usernameTextField.text!
            let password: String = self.passwordTextField.text!
            self.presenter?.doLogin(username: username, password: password)
        }
    }
    
    /// Action to dismiss the keyboard
    ///
    /// - Parameter sender: Any object
    @IBAction func tapAction(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    /// Swipe action from the view to dismiss the view
    ///
    /// - Parameter sender: Any object
    @IBAction func dismissMeAction(_ sender: Any) {
        self.didSwipe()
    }
    
    // MARK: Payment Methods
    @IBAction func paymentMethodsAction(_ sender: Any) {
        self.presenter?.selectPaymentMethod()
    }
    
    // MARK: LoginViewProtocol
    func loginDone() {
        self.stopAnimating()
        didSwipe()
    }
    
    /// Shows a spinner in the view
    func startAnimating() {
//        super.startAnimating()
    }
    
    /// Dimisses the spinner from the view
    func stopAnimating() {
//        super.stopAnimating()
    }

    func show(error: String) {
        self.stopAnimating()
        super.showErrorInAlert(message: error, title: "")
    }
    
    /// Shows an error in an alert
    ///
    /// - Parameter error: String with the error
    func showError(error: String) {
        super.showErrorInAlert(message: error, title: kErrorTitle)
    }
    
    
    func userAlreadyLoggedIn(user: User) {
        self.isUserAlreadyLoggedIn = true
        self.viewLoggedIn.isHidden = false
        self.buttonLogin.setTitle("Logout", for: .normal)
        self.usernameTextField.isHidden = true
        self.passwordTextField.isHidden = true
        self.lblUserName.text = user.username
        self.lblFirstName.text = user.firstName
        self.lblLastName.text = user.lastName
    }
    
    func userNotLoggedIn() {
        self.isUserAlreadyLoggedIn = false
        self.viewLoggedIn.isHidden = true
        self.buttonLogin.setTitle("Login", for: .normal)
        self.usernameTextField.isHidden = false
        self.passwordTextField.isHidden = false
    }
    
    // MARK: Keyboard methods
    
    /// Registers the view controller to be a listener when the keyboard will be show and hidden
    fileprivate func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillBeShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    /// Un-registers the view controller to be a listener when the keyboard will be show and hidden
    fileprivate func deregisterForKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// When the keyboard will be shown, handles the view to check if all the necessary views are availables to the user
    ///
    /// - Parameter notification: Notification with the keyboard information
    @objc
    func keyboardWillBeShown(notification:NSNotification){
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let animationDuration: TimeInterval = info.object(forKey: UIResponder.keyboardAnimationDurationUserInfoKey) as! TimeInterval
        if let keyboardSize = info.object(forKey: UIResponder.keyboardFrameBeginUserInfoKey) as? CGRect {
            var buttonOrigin: CGPoint = self.passwordTextField.frame.origin
            let buttonHeight: CGFloat = self.passwordTextField.frame.size.height
            
            var visibleRect:CGRect  = self.view.frame
            var newFrame: CGRect = visibleRect
            
            visibleRect.size.height -= keyboardSize.height;
            buttonOrigin.y = buttonOrigin.y + buttonHeight;
            
            if (!visibleRect.contains(buttonOrigin)){
                //move up only enough to show login btn again
                newFrame.origin.y = -buttonOrigin.y + visibleRect.size.height;
                UIView.animate(withDuration: animationDuration, animations: {
                    self.view.frame = newFrame
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    /// When the keyboard will be hidden, restores the view to the normal frame
    ///
    /// - Parameter notification: Notification with the keyboard information
    @objc
    func keyboardWillBeHidden(notification:NSNotification){
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let animationDuration: TimeInterval = info.object(forKey: UIResponder.keyboardAnimationDurationUserInfoKey) as! TimeInterval
        var newFrame: CGRect = self.view.frame
        newFrame.origin.y = 0
        UIView.animate(withDuration: animationDuration, animations: {
            self.view.frame = newFrame
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    /// Handles the return button
    ///
    /// - Parameter textField: Textfield that is first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.passwordTextField {
            textField.resignFirstResponder()
            self.loginAction(self)
            return false
        }
        return true
    }
}
