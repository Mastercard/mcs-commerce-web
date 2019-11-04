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

import UIKit

class objectLocator: NSObject {
    
    struct SettingScreenStruct {
        
        static let tableView_Identifier              = "SETTING_TABLEVIEW"
        static let allowedCardType_Identifier        = "ALLOWED_CARD_TYPE"
        static let changeLanguage_Identifier         = "LANGUAGE"
        static let changeCurrency_Identifier         = "CURRENCY"
        static let changeShipping_Identifier         = "SHIPPING"
        static let surpressShippingToggle_Identifier = "SUPRESS_SHIPPING"
        static let paymentMethodToggle_Identifier    = "PAYMENTMETHOD"
        static let expressCheckoutToggle_Identifier  = "EXPRESS_CHECKOUT"
        static let changeTokenization_Identifier     = "TOKENIZATION"
        static let changePaymentMethod_Identifier    = "PAYMENT_METHODS"
        static let backButton_Identifier             = "SETTING_BACK_BUTTON"
    }
    
    struct loginScreenStruct {
        
        static let txtPassword_Identifier   = "TXT_PASSWORD"
        static let txtUsername_Identifier   = "TXT_USERNAME"
        static let btnLogin_Identifer       = "BTN_LOGIN"
        static let btnDismiss_Identifer     = "BTN_DISMISS"
    }
    
    struct productListScreenStruct {
        
        static let btnShoppingCart_Identifer    = "BTN_SHOPPINGCART"
        static let btnAddProduct_Identifer      = "BTN_ADDPRODUCT"
    }
    
    struct orderSummeryScreenStruct {
        
        static let backButton_Identifier          = "ORDER_SUMMERY_BACK_BUTTON"
        static let btnIncreaseQuantity_Identifer  = "INCREASE_QUANTITY"
        static let btnDecreaseQuantity_Identifer  = "DECREASE_QUANTITY"
        static let lblProductPrice_Identifer      = "PRICE_TOTAL"
        static let btnMasterpass_Identifier       = "BTN_MASTERPASS"
        static let lblTotalAmount_Identifier      = "CART_TOTAL_AMOUNT"
    }
    
    struct allowCardListScreenStruct {
        
        static let cardBrand_Identifier           = "CARDBRAND_ID"
        static let backButton_Identifier          = "ALLOWCARD_BACK_BUTTON"
    }
    
    struct allowDSRPListScreenStruct {
        
        static let DSRP_Identifier                = "DSRP_ID"
        static let backButton_Identifier          = "ALLOWDSRP_BACK_BUTTON"
    }
    
    struct currencyListScreenStruct {
        
        static let currency_Identifier            = "CURRENCY_ID"
        static let backButton_Identifier          = "CURRENCYLIST_BACK_BUTTON"
    }
    
    struct languageListScreenStruct {
        
        static let language_Identifier            = "LANGUAGE_ID"
        static let backButton_Identifier          = "LANGUAGELIST_BACK_BUTTON"
    }
    
    struct paymentMethodsListScreenStruct {
        
        static let paymentMethod_Identifier       = "PAYMENTMETHOD_ID"
        static let backButton_Identifier          = "PAYMENTMETHOD_BACK_BUTTON"
    }
    
    struct confirmOrderScreenStruct {
        
        static let btnCancel_Identifier           = "BTN_CANCEL"
        static let btnConfirm_Identifier          = "BTN_CONFIRM"
        static let btnshoppingCart_Identifier     = "BTN_SHOPPINGCART"
        static let backButton_Identifier          = "ORDER_SUMMERY_BACK_BUTTON"
        
    }
    
    struct transectionCompleteScreenStruct {
        
        static let btnContinuShopping_Identifier  = "BTN_CONTINUE_SHOPPING"
        static let backButton_Identifier          = "TRANSECTION_COMPLETE_BACK_BUTTON"
    }
    
    struct transactionFailureStruct {
        static let btnRetryCheckout_Identifier    = "BTN_RETRYCHECKOUT"
        static let btnCart_Identifier             = "BTN_CART"
    }
    
    struct SRCEnrollCardStruct {
        
        static let txtCardHolderName_Identifier           = "TextField_CardHolderName_View_AddCardScreen"
        static let txtCardNumber_Identifier               = "TextField_CardNumber_View_AddCardScreen"
        static let txtExpiry_Identifier                   = "TextField_CardExpiry_View_AddCardScreen"
        static let txtCvv_Identifier                      = "TextField_CVV_View_AddCardScreen"
        static let btnContinue_Identifier                 = "Button_Continue_View_AddCardScreen"
        static let btnCancelAndReturn_Identifier          = "Button_Cancel_View_AddCardScreen"
        static let btnOK_Identifier                       = "OK"
        static let btnCardDetails_Identifier              = "Enter your payment information"
        static let tabNewUser_Identifier                  = "Button_NewUser_View_AddCardScreen"
        static let tabReturningUser_Identifier            = "Button_ReturningUser_View_AddCardScreen"
        static let txtEmail_Identifier                    = "Email Address"
        static let lbl_MerchantName_Identifier            = "Label_PayToName_View_AddCardScreen"
        static let lbl_TotolAmount_Identifier             = "Label_PayToAmt_View_AddCardScreen"
        static let btnTandC_Identifier                   = "Button_TermsCondition_View_CopyRight_SRCi"
        static let btnPrivacy_Identifier                 = "Button_PrivacyNotice_View_CopyRight_SRCi"
        static let btnCookie_Identified                  = "Button_CookieConsent_View_CopyRight_SRCi"
        
        
    }
    
    struct SRCAssociateStruct {
        static let txtBillingFirstName         =  "TextField_InputView_FirstName_View_BillingAddress"
        static let txtBillingLastName          =  "TextField_InputView_LastName_View_BillingAddress"
        static let txtBillingAddressLine1_Identifier      = "TextField_InputView_Address1_View_BillingAddress"
        static let txtBillingAddressLine2_Identifier      = "TextField_InputView_Address2_View_BillingAddress"
        static let txtBillingCity_Identifier              = "TextField_InputView_City_View_BillingAddress"
        static let txtBiilingState_Identifier             = "TextField_InputView_State_View_BillingAddress"
        static let txtBillingZip_Identifier               = "TextField_InputView_ZipCode_View_BillingAddress"
        
        static let txtShippingFirstName    = "TextField_InputView_FirstName_View_ShippingAddress"
        static let txtShippingLastName     = "TextField_InputView_LastName_View_ShippingAddress"
        static let txtShippingAddressLine1_Identifier  = "TextField_InputView_Address1_View_ShippingAddress"
        static let txtShippingAddressLine2_Identifier  = "TextField_InputView_Address2_View_ShippingAddress"
        static let txtShippingCity_Identifier        = "TextField_InputView_City_View_ShippingAddress"
        static let txtShippingState_Identifier       = "TextField_InputView_State_View_ShippingAddress"
        static let txtShippingZip_Identifier         = "TextField_InputView_ZipCode_View_ShippingAddress"
        
        
        static let txtEmail_Identifier                   = "TextField_InputView_EmailAddress_View_ProfileInfo"
        static let txtPhone_Identifier                   = "TextField_InputView_MobileNumber_View_ProfileInfo"
        static let btnContinue_Identifier                = "Button_Continue_View_Continue_DCF"
        static let checkBox_BillingAsShipping            = "Button_CheckMark_View_BillingAddress"
        static let checkBox_McOffers                     = "Button_CheckMark_View_ProfileInfo"
        static let btnCancelAndReturn_Identifier         = "Button_CancelTransaction_View_Continue_DCF"
        static let lblEstimatedAmount_Identifier         = "Label_Amount_View_PaymentScreen"
        static let lblMerchantName_Identifier            = "Label_MerchantName_View_PaymentScreen"
        static let lblCardName_Identifier                = "Label_CardBrand_View_CardInfo"
        static let lblCardNumber_Identifier              = "Label_MaskedCardNumber_View_CardInfo"
        
    }
    
    struct SRCProfileReviewStruct {
        
        static let btnContinue_Identifier                = "Button_Continue_View_Continue_DCF"
        static let btnCancelAndReturn_Identifier         = "Button_CancelTransaction_View_Continue"
        static let btnTandC_Identifier                   = "Button_TermsCondition_View_CopyRight_DCF"
        static let btnPrivacy_Identifier                 = "Button_PrivacyNotice_View_CopyRight_DCF"
        static let btnCookie_Identified                  = "Button_CookieConsent_View_CopyRight_DCF"
        static let btnEditShippingAddress_Identifier     = "Button_EditShippingAddress_View_PaymentScreen"
        static let btnEditCard_Identifier                = "Button_CardList_View_CardInfo"
        static let viewConsumerName_Identifier           = "Label_FullName_View_PaymentScreen"
        static let viewAddressline1_Identifier           = "Label_Address1_View_PaymentScreen"
        static let viewAddressline2_Identifier           = "Label_Address2_View_PaymentScreen"
        static let viewCitySateZip_Identifier            = "Label_City_View_PaymentScreen"
        static let viewEmail_Identifier                  = "Label_Email_View_PaymentScreen"
        static let viewPhone_Identifier                  = "Label_MobileNumber_View_PaymentScreen"
        static let lblTotalAmount_Identifier             =  "Label_Amount_View_PaymentScreen"
        static let lblMerchantName_Identifier            =  "Label_MerchantName_View_PaymentScreen"
        static let lblCardName_Identifier                = "Label_CardBrand_View_CardInfo"
        static let lblCardNumber_Identifier              = "Label_MaskedCardNumber_View_CardInfo"
        static let btnEditShippingAddress                = "Button_EditShippingAddress_View_PaymentScreen"
        
    }
    
    struct SRCRememberMeStruct {
        
        static let btnRememberMe_Identifier              = "Button_RememberMe_View_RememberMe"
        static let btnNotNow_Identifier                  = "Button_NotNow_View_RememberMe"
        
        
    }
    
    struct SRCAddressListStruct {
        static let btnAddShippingAddress_Identifier      = "Button_AddShippingAddress_View_ShippingAddressList"
        static let btnCancelCheckout_Identifier          = "Button_CancelTransaction_View_ShippingAddressList"
        static let btnSelectAddress_Identifier           = "Table_View_ShippingAddressList"
        static let btnCancelTransaction_Identifier       = "Button_CancelTransaction_View_ShippingAddressList"
        static let btnSelectFirstAddress_Identifier      = "Table_View_ShippingAddressList"
        static let btnCancelTransaction_IdentifierCommon = "Button_CancelTransaction_View_ShippingAddressList"
        static let btnAddAddress_Identifier              = "Add"
        static let btnTnC_Identifier                     = "Button_TermsCondition_View_CopyRight_DCF"
        static let btnPP_Identifier                      = "Button_PrivacyNotice_View_CopyRight_DCF"
        static let btnCC_Identifier                      = "Button_CookieConsent_View_CopyRight_DCF"
        static let txtAddAShippingAddress                = "Add a shipping address"
        static let txtCopyRight_Mastercard               = "Copyright ©2018 Mastercard. All Rights Reserved."
        static let lblShippingAddressList_Identifier     = "Choose a shipping address"
    }
    
    struct SRCCardListScreen {
        static let btnAddCard_Identifier = "Button_AddCard_View_RoutingSheet"
        static let btnCancelTransaction_Identifier = "Button_CancelTransaction_View_RoutingSheet"
        static let lblCardListTitle_Idenfier             = "Choose a payment method"
        static let tblCardList_Identifier                = "Table_View_RoutingSheet"
        static let btnCancelandReturnMerchantLink_Identifier = "Button_CancelTransaction_View_RoutingSheet"
    }
    
    struct otpScreen {
        static let txtOtp_Identifier = "TextField_View_OTPValidation"
        static let btnContinue_Identifier = "Button_Continue_View_Continue"
    }
    
}
