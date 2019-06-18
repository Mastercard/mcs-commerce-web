# MCSCommerceWeb SDK

1. [Overview](#ios-overview)
1. [Configuration](#ios-configuration)
1. [Checkout](#ios-checkout)
1. [Checkout Button](#ios-checkout-button)
1. [Migrating from MCCMerchant](#ios-masterpass)

### <a name="ios-overview">Overview</a>

MCSCommerceWeb SDK is a lightweight component used to integrate Merchants with [**EMV Secure Remote Commerce**](https://www.emvco.com/emv-technologies/src/) and Mastercard's web-based SRC-Initiator. MCSCommerceWeb facilitates the initiation of the checkout experience as well as returning the transaction result to the Merchant after completion.

### <a name="ios-configuration">Configuration</a>
When instantiating `MCSCommerceWeb`, an `MCSConfiguration` object needs to be provided.

`MCSConfiguration` requires the following parameters:

* `locale`: This is the locale in which the transaction is processing
* `checkoutId`: The unique identifier assigned to the merchant during onboarding
* `checkoutUrl`: The URL used to load the checkout experience. Note: when testing in the Sandbox environment, use `https://sbx.src.mastercard.com/srci`. For Production, use  `https://src.mastercard.com/srci`. See below table for Masterpass URLs which can be used here.
* `callbackScheme`: This must match the scheme component of the `callbackUrl` configured for this merchant. This value is used to verify the callback redirect from SRCi.
* `allowedCardTypes` : The payment networks supported by this merchant (e.g. master, visa, amex).


```swift
let locale = Locale(identifier: "en_us")
let checkoutId = "1d45705100044e14b52e71730e71cc5a"
let checkoutUrl = "https://src.mastercard.com/srci";
let callbackScheme = "fancyshop";
let allowedCardTypes = [.master, .visa]
    
let commerceConfig = MCSConfiguration(
    locale: locale,
    checkoutId: checkoutId,
    checkoutUrl: checkoutUrl,
    callbackScheme: callbackScheme,
    allowedCardTypes: allowedCardTypes)
    
let commerceWeb = MCSCommerceWeb(configuration: commerceConfig)
```

### <a name="ios-checkout-button">Checkout Button</a>

One option for initiating a transaction is to use the `MCSCheckoutButton` returned by 

```swift
//MCSCommerceWeb.h
- (MCSCheckoutButton *)checkoutButtonWithDelegate:(id<MCSCheckoutDelegate>)delegate;
```

Use the `addButtonToView:` message to send the `superview` to attach this button to.

#### MCSCheckoutDelegate

the `MCSDelegate` object sent to `checkoutButtonWithDelegate:` will receive `checkoutRequestForTransaction:`, which should provide the `MCSCheckoutRequest` to complete this transaction.

### <a name="ios-checkout">Checkout</a>

The second option for initiating a transaction is to send `checkoutWithRequest:completionHandler` to `MCSCommerceWeb`.

Calling `checkout(with: MCSCheckoutRequest, (MCSCheckoutStatus, String?) -> ())` on the `MCSCommerceWeb` object will initiate the checkout experience.

* `request`: Data object with transaction-specific parameters needed to complete checkout. This request can also override existing merchant configurations.
	* Required fields:
		*  `allowedCardTypes`: Set of all card types accepted for this transaction
		*  `amount`: The transaction total to be authorized
		*  `cartId`: Merchant's unique identifier for this transaction
	* Optional Fields: These fields can be assigned to override the default values configured by the merchant.
		* `callbackUrl`: URL used to communicate back to the merchant application
		* `cryptoOptions`: Cryptogram formats accepted by this merchant
		* `cvc2Support`: Enable or disable support for CVC2 card security
		* `shippingLocationProfile`: Shipping locations available for this merchant
		* `suppress3Ds`: Enable or disable 3DS verification
		* `suppressShippingAddress`: Enable or disable shipping options. Typically for digital goods or services, this will be set to `true`.
		* `unpredictableNumber`: For tokenized transactions, `unpredictableNumber` is required for cryptogram generation
		* `validityPeriodMinutes`: the expiration time of a generated cryptogram, in minutes

```swift
let checkoutRequest = MCSCheckoutRequest()
checkoutRequest.amount = NSDecimalNumber(string: String(shoppingCart.total))
checkoutRequest.currency = sdkConfig.currency
checkoutRequest.cartId = shoppingCart.cartId
checkoutRequest.allowedCardTypes = [.master,.visa]
checkoutRequest.suppressShippingAddress = sdkConfig.suppressShipping
checkoutRequest.callbackUrl = "MerchantApp://"
checkoutRequest.unpredictableNumber = "12345678"
    
let cryptoOptionVisa = MCSCryptoOptions()
cryptoOptionVisa.cardType = "visa"
cryptoOptionVisa.format = ["TVV"]

let cryptoOptionMaster = MCSCryptoOptions()
cryptoOptionMaster.cardType = "master"
cryptoOptionMaster.format = ["ICC,UCAF"]

checkoutRequest.cryptoOptions = [cryptoOptionMaster,cryptoOptionVisa]
    
commerceWebSdk.checkout(with: checkoutRequest) { (status: MCSCheckoutStatus, transactionId: String?) in
	if (MCSCheckoutStatus == MCSCheckoutStatus.success) {
		//complete transaction
	} else {
		//transaction canceled
	}
}
```

Optionally, a delegate can be assigned to `commerceWebSdk`

```swift
commerceWebSdk.delegate = self
```

`self` must then conform to the `MCSCommerceDelegate` protocol.

```swift
func checkoutDidComplete(with status: MCSCheckoutStatus, forTransaction transactionId: String?) {
    if (status == MCSCheckoutStatus.success) {
        //complete transaction
    } else {
        //transaction canceled
    }
}
```

### <a name='ios-masterpass'>Migrating from MCCMerchant</a>

If an existing application is using `MCCMerchant` today, it is easy to migrate to `MCSCommerceWeb` with minimal changes. Consider the following when migrating from `MCCMerchant` to `MCSCommerceWeb`

#### Interfaces

The `MCCMerchant` interface is included in this SDK, however `import` statements must update to use the `MCSCommerceWeb` module.

```swift
//swift
//previous import statement
import MCCMerchant

//current import statement
import MCSCommerceWeb

//objective-c
//previous
#import <MCCMerchant/MCCMerchant.h>

//current
#import <MCSCommerceWeb/MCSCommerceWeb.h>
```

##### MCCConfiguration

`MCCConfiguration` has 4 new required properties

* `checkoutId` : The merchant identifier generated when created a merchant developer profile. Note: this is moved from `MCCCheckoutRequest`
* `allowedCardTypes` : The payment networks supported by this merchant (e.g. master, visa, amex). Note: this is moved from `MCCCheckoutRequest`
* `callbackScheme` : The scheme used to return data to this application. This is the value configured in `URL Schemes` in the `info.plist`
* `checkoutUrl` : The URL used to load the checkout experience. Note: if you are migrating to `MCSCommerceWeb`, but still plan to checkout with `Masterpass`, you will still need to provide this URL.

|Environment | URL	|
|--------------------|----------------------------------|
|Masterpass Sandbox	 | https://sandbox.masterpass.com/routing/v2/mobileapi/web-checkout	 |
|Masterpass Production | https://masterpass.com/routing/v2/mobileapi/web-checkout |
|SRCi Sandbox			| https://sbx.src.mastercard.com/srci |
|SRCi Production		| https://src.mastercard.com/srci |

##### Handle checkout response

```swift
//MCCMerchant.h
+ (BOOL)handleMasterpassResponse:(NSString *_Nonnull)url delegate:(id<MCCMerchantDelegate> _Nonnull)merchantDelegate ;
```

`handleMasterpassResponse:delegate` no longer has any effect. This `MCSCommerceWeb` implements `WKWebView` instead of `SFSafariViewController`, this the checkout response is handled using `MCCDelegate` directly. The `MCCDelegate` provided in any checkout calls will be the delegate that receives the checkout response.

##### Add Payment Method

```swift
//MCCMerchant.h
+ (void)addMasterpassPaymentMethod:(id<MCCMerchantDelegate> _Nonnull)merchantDelegate withCompletionBlock:(void(^ __nonnull) (MCCPaymentMethod*  _Nullable mccPayment, NSError * _Nullable error))completionHandler;
```

`addMasterpassPaymentMethod:withCompletionBlock:` will always return the same payment method with the following properties:

* `paymentMethodName` : `Masterpass`
* `paymentMethodId` : `101`
* `paymentMethodLogo` : The Masterpass logo as `UIImage`

This payment method, or any other, can be used with `paymentMethodCheckout:` to initiate a standard checkout flow (see next).

`didGetPaymentMethod:` is never sent to `MCCMerchantDelegate`.

##### Payment Method Checkout

```swift
//MCCMerchant.h
+ (void)paymentMethodCheckout:(id<MCCMerchantDelegate> _Nonnull) merchantDelegate;
```

`paymentMethodCheckout:` will initiate the standard checkout flow and the `loadPaymentMethod` message will not be sent to `MCCMerchantDelegate`. 

##### Pairing With Checkout

```swift
//MCCMerchant.h
+ (void)pairingWithCheckout:(BOOL)isCheckout merchantDelegate:(id<MCCMerchantDelegate> _Nonnull) merchantDelegate;
```

`pairingWithCheckout:merchantDelegate:` will initiate the standard checkout flow if the `isCheckout` value is `YES`. Otherwise, `didFinishCheckout:` is directly messaged to `MCCMerchantDelegate` as if the transaction was canceled.

