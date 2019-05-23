# MCSCommerceWeb SDK

1. [Overview](#ios-overview)
1. [Configuration](#ios-configuration)
1. [Checkout](#ios-checkout)

### <a name="ios-overview">Overview</a>

MCSCommerceWeb SDK is a lightweight component used to integrate Merchants with [**EMV Secure Remote Commerce**](https://www.emvco.com/emv-technologies/src/) and Mastercard's web-based SRC-Initiator. MCSCommerceWeb facilitates the initiation of the checkout experience as well as returning the transaction result to the Merchant after completion.

### <a name="ios-configuration">Configuration</a>
When instantiating `MCSCommerceWeb`, an `MCSConfiguration` object needs to be provided.

`MCSConfiguration` requires the following parameters:

* `locale`: This is the locale in which the transaction is processing
* `checkoutId`: The unique identifier assigned to the merchant during onboarding
* `baseUrl`: The base URL of the SRCi to load, e.g. `src.mastercard.com`
* `callbackScheme`: This must match the scheme component of the `callbackUrl` configured for this merchant. This value is used to verify the callback redirect from SRCi.


```swift
let locale = Locale(identifier: "en_us")
let checkoutId = "1d45705100044e14b52e71730e71cc5a"
let baseUrl = "src.mastercard.com";
let callbackScheme = "customscheme";
    
let commerceConfig = MCSConfiguration(
    locale: locale,
    checkoutId: checkoutId,
    baseUrl: baseUrl,
    scheme: callbackScheme)
    
let commerceWeb = MCSCommerceWeb(configuration: commerceConfig)
```


### <a name="ios-checkout">Checkout</a>

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

