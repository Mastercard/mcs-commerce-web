# MCSCommerceWeb

1. [Overview](#ios-overview)
1. [Installation](#ios-installation)
1. [Configuration](#ios-configuration)
1. [Checkout Button](#ios-checkout-button)
1. [Checkout](#ios-checkout)
1. [Migrating from MCCMerchant](#ios-masterpass)

### <a name="ios-overview">Overview</a>

`MCSCommerceWeb` is a lightweight framework used to integrate Merchants with [**EMV Secure Remote Commerce**](https://www.emvco.com/emv-technologies/src/) and Mastercard's web-based SRC-Initiator with backward compatibility for existing Masterpass integrations. `MCSCommerceWeb` facilitates the initiation of the checkout experience and returns the transaction result to the Merchant after completion.

***Note: currently, this framework is only re ommended for existing U.S. Masterpass merchants.***

### <a name="ios-installation">Installation</a>

#### CocoaPods

To include `MCSCommerceWeb` in your Xcode project, include the following in your project's `Podfile`:

``` 
pod 'MCSCommerceWeb', '~> 1.0.0-beta3'
```

### <a name="ios-configuration">Configuration</a>
When instantiating `MCSCommerceWeb`, an `MCSConfiguration` object needs to be provided.

`MCSConfiguration` requires the following parameters:

* `locale`: This is the locale in which the transaction is processing
* `checkoutId`: The unique identifier assigned to the merchant during onboarding
* `checkoutUrl`: The URL used to load the checkout experience. *Note: when testing in the Sandbox environment, use `https://sandbox.masterpass.com/routing/v2/mobileapi/web-checkout `. For Production, use  `https://masterpass.com/routing/v2/mobileapi/web-checkout `.*
* `callbackScheme`: This must match the scheme component of the `callbackUrl` configured for this merchant. This value is required to redirect back from the `WKWebView`
* `allowedCardTypes` : The payment networks supported by this merchant (e.g. master, visa, amex).


```swift
//Swift
let locale = Locale(identifier: "en_us")
let checkoutId = "1d45705100044e14b52e71730e71cc5a"
let checkoutUrl = "https://masterpass.com/routing/v2/mobileapi/web-checkout";
let callbackScheme = "fancyshop";
let allowedCardTypes = [.master, .visa]
    
let commerceConfig = MCSConfiguration(
    locale: locale,
    checkoutId: checkoutId,
    checkoutUrl: checkoutUrl,
    callbackScheme: callbackScheme,
    allowedCardTypes: allowedCardTypes)
    
let commerceWeb = MCSCommerceWeb.sharedManager()
commerceWeb.setConfiguration(withConfiguration: commerceConfig)
```

```objective-c
//Objective-C
NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_us"];
NSString *checkoutId = @"1d45705100044e14b52e71730e71cc5a";
NSString *checkoutUrl = @"https://masterpass.com/routing/v2/mobileapi/web-checkout";
NSString *callbackScheme = @"fancyshop";
NSSet *allowedCardTypes = [NSSet setWithObject:MCSCardTypeMaster, MCSCardTypeVisa];
MCSConfiguration *config = [[MCSConfiguration alloc] initWithLocale:locale
                                                         checkoutId:checkoutId
                                                        checkoutUrl:checkoutUrl
                                                     callbackScheme:callbackScheme
                                                   allowedCardTypes:allowedCardTypes];

MCSCommerceWeb *commerceWeb = [MCSCommerceWeb sharedManager];
[commerceWeb initWithConfiguration:config];
```

### <a name="ios-checkout-button">Checkout Button</a>

One option for initiating a transaction is to add the `MCSCheckoutButton` to the view, allowing the user to touch on it.

```swift
//Swift
//SomeViewController.swift
let button = commerceWeb.getCheckoutButton(withDelegate:checkoutDelegate)
button.addToSuperview(superview: buttonContainer)
```

```objective-c
//Objective-C
//SomeViewController.m
MCSCheckoutButton *button = [commerceWeb checkoutButtonWithDelegate:checkoutDelegate];
[button addToSuperview:buttonContainer];
```


#### `withDelegate:`


The `MCSDelegate` provided has the following methods:

```swift
//Swift
//Fetches the checkout request object required to initiate this transaction.
func getCheckoutRequest(withHandler: @escaping (MCSCheckoutRequest) -> Void)

//Notifies the delegate when the transaction has completed
func checkoutCompleted(withRequest request: MCSCheckoutRequest, status: MCSCheckoutStatus, transactionId: String?)
```

```c
//Objective-C
//Fetches the checkout request object required to initiate this transaction.
- (void)checkoutRequestForTransaction:(nonnull void(^)(MCSCheckoutRequest * _Nonnull checkoutRequest))handler;

//Notifies the delegate when the transaction has completed
- (void)checkoutRequest:(MCSCheckoutRequest *)request didCompleteWithStatus:(MCSCheckoutStatus)status forTransaction:(NSString * _Nullable)transactionId;
```



### <a name="ios-checkout">Checkout</a>

The second option for initiating a transaction is to call

```swift
//Swift
func checkout(withRequest: MCSCheckoutRequest, completionHandler: ((MCSCheckoutStatus, String?) -> Void)?)
```

```objective-c
//Objective-C
- (void)checkoutWithRequest:(MCSCheckoutRequest *_Nonnull)request completionHandler:(void (^ _Nullable)(MCSCheckoutStatus status, NSString * _Nullable transactionId))completion;
```

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
//Swift
let checkoutRequest = MCSCheckoutRequest()
checkoutRequest.amount = NSDecimalNumber(string: String(shoppingCart.total))
checkoutRequest.currency = sdkConfig.currency
checkoutRequest.cartId = shoppingCart.cartId
checkoutRequest.allowedCardTypes = [.master,.visa]
checkoutRequest.suppressShippingAddress = sdkConfig.suppressShipping
checkoutRequest.callbackUrl = "fancyshop://"
checkoutRequest.unpredictableNumber = "12345678"
    
let cryptoOptionVisa = MCSCryptoOptions()
cryptoOptionVisa.cardType = "visa"
cryptoOptionVisa.format = ["TVV"]

let cryptoOptionMaster = MCSCryptoOptions()
cryptoOptionMaster.cardType = "master"
cryptoOptionMaster.format = ["ICC,UCAF"]

checkoutRequest.cryptoOptions = [cryptoOptionMaster,cryptoOptionVisa]
    
commerceWeb.checkout(with: checkoutRequest) { (status: MCSCheckoutStatus, transactionId: String?) in
	if (MCSCheckoutStatus == MCSCheckoutStatus.success) {
		//complete transaction
	} else {
		//transaction canceled
	}
}
```

```objective-c
//Objective-C
MCSCheckoutRequest *checkoutRequest = [MCSCheckoutRequest alloc] init];
checkoutRequest.amount = [[NSDecimalNumber alloc] initWithString:shoppingCart.total];
checkoutRequest.currency = sdkConfig.currency
checkoutRequest.cartId = shoppingCart.cartId
checkoutRequest.allowedCardTypes = [NSSet setWithObjects:MCSCardTypeMaster, MCSCardTypeVisa, nil];
checkoutRequest.suppressShippingAddress = sdkConfig.suppressShipping;
checkoutRequest.callbackUrl = @"fancyshop://";
checkoutRequest.unpredictableNumber = @"12345678";

MCSCryptoOptions *cryptoOptionMaster = [[MCSCryptoOptions alloc] init];
cryptoOptionMaster.cardType = MCSCardTypeMaster;
cryptoOptionMaster.format = @[MCSCryptoFormatICC, MCSCryptoFormatUCAF];

checkoutRequest.cryptoOptions = @[cryptoOptionMaster];

[commerceWeb checkoutWithRequest:checkoutRequest completionHandler:^(MCSCheckoutStatus status, NSString * _Nullable transactionId) {
  //Checkout complete
  //Completion handler can be null
}];
```

Optionally, a delegate can be assigned to `commerceWeb`

```swift
//Swift
commerceWeb.delegate = checkoutDelegate
```

```objective-c
//Objective-C
commerceWeb.delegate = checkoutDelegate;
```

### <a name='ios-masterpass'>Migrating from MCCMerchant</a>

If an existing application is using `MCCMerchant` today, it is easy to migrate to `MCSCommerceWeb` with minimal changes. Consider the following when migrating from `MCCMerchant` to `MCSCommerceWeb`

#### Interfaces

The `MCCMerchant` interface is included in this SDK, however `import` statements must update to use the `MCSCommerceWeb` module.

```swift
//Swift
//previous import statement
import MCCMerchant

//current import statement
import MCSCommerceWeb
```

```objective-c
//Objective-C
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

| Environment           | URL	                                                              |
|-----------------------|-------------------------------------------------------------------|
| Masterpass Sandbox    | https://sandbox.masterpass.com/routing/v2/mobileapi/web-checkout  |
| Masterpass Production | https://masterpass.com/routing/v2/mobileapi/web-checkout          |


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

