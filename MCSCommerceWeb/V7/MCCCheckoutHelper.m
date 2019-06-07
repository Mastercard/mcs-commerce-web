//
//  MCCCheckoutHelper.m
//  MCSCommerceWeb
//
//  Created by Deasy, Bret on 5/30/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import "MCCCheckoutHelper.h"
#import "MCSCheckoutRequest.h"
#import "MCSConfiguration.h"
#import "MCCMerchantConstants.h"
#import "MCCMerchantConstants+Private.h"
#import "MCFEnvironmentConfiguration.h"

@implementation MCCCheckoutHelper


+ (MCSCommerceWeb *) checkoutWithConifg:(MCCConfiguration *)config request:(MCCCheckoutRequest *)request completionHandler:(void (^ _Nullable)(MCSCheckoutStatus status, NSString * _Nullable transactionId))completion {
    
    MCFEnvironmentConfiguration *envConfig = [MCFEnvironmentConfiguration sharedInstance];
    MCSConfiguration *commerceConfig = [[MCSConfiguration alloc] initWithLocale:config.locale
                                                                     checkoutId:request.checkoutId
                                                                        baseUrl:envConfig.checkoutHost
                                                                 callbackScheme:config.callbackScheme];
    MCSCommerceWeb *commerceWeb = [[MCSCommerceWeb alloc] initWithConfiguration:commerceConfig];
    MCSCheckoutRequest *commerceRequest = [MCCCheckoutHelper requestWithRequest:request];
    
    
    [commerceWeb checkoutWithRequest:commerceRequest completionHandler:completion];
    
    return commerceWeb;
}

+ (MCSCheckoutRequest *)requestWithRequest:(MCCCheckoutRequest *)request {
    MCSCheckoutRequest *newRequest = [[MCSCheckoutRequest alloc] init];
    newRequest.allowedCardTypes = [MCCCheckoutHelper cardTypesWithCardTypes:request.allowedCardTypes];
    newRequest.amount = request.amount.total;
    newRequest.cartId = request.cartId;
    newRequest.currency = request.amount.currencyCode;
    newRequest.suppressShippingAddress = !request.isShippingRequired;
    newRequest.callbackUrl = request.callbackUrl;
    newRequest.cryptoOptions = [MCCCheckoutHelper cryptoOptionsWithCryptoTypes:request.cryptogramTypes];
    newRequest.cvc2Support = [NSNumber numberWithBool:request.cvc2support];
    newRequest.shippingLocationProfile = request.shippingProfileId;
    newRequest.suppress3Ds = [NSNumber numberWithBool:request.suppress3DS];
    newRequest.unpredictableNumber = request.unpredictableNumber;
    newRequest.validityPeriodMinutes = [NSNumber numberWithInteger:request.validityPeriodMinutes];
    
    return newRequest;
}

+ (NSSet<MCSCardType> *)cardTypesWithCardTypes:(NSSet<MCCCardType *> *)cardTypes {
    NSMutableSet<MCSCardType> *newCardTypes = [[NSMutableSet alloc] init];
    for (MCCCardType *card in cardTypes) {
        MCSCardType cardType;
        
        switch (card.cardType) {
            case MCCCardMASTER:
                cardType = MCSCardTypeMaster;
                break;
            case MCCCardVISA:
                cardType = MCSCardTypeVisa;
                break;
            case MCCCardMAESTRO:
                cardType = MCSCardTypeMaestro;
                break;
            case MCCCardAMEX:
                cardType = MCSCardTypeAmex;
                break;
            case MCCCardDISCOVER:
                cardType = MCSCardTypeDiscover;
                break;
            case MCCCardDINERS:
                cardType = MCSCardTypeDiners;
                break;
        }
        
        [newCardTypes addObject:cardType];
    }
    
    return newCardTypes;
}

+ (NSArray <MCSCryptoOptions *> *)cryptoOptionsWithCryptoTypes:(NSArray <MCCCryptogram *> *)cryptograms {
    if (cryptograms == nil) {
        return nil;
    }
    
    MCSCryptoOptions *mastercardCryptoOptions = [[MCSCryptoOptions alloc] init];
    NSMutableSet *mastercardCryptoFormats = [[NSMutableSet alloc] init];
    mastercardCryptoOptions.cardType = MCSCardTypeMaster;
    
    MCSCryptoOptions *visaCryptoOptions = [[MCSCryptoOptions alloc] init];
    NSMutableSet *visaCryptoFormats = [[NSMutableSet alloc] init];
    visaCryptoOptions.cardType = MCSCardTypeVisa;
    
    for (MCCCryptogram *cryptogram in cryptograms) {
        switch (cryptogram.cryptogramType) {
            case MCCCryptogramICC:
                [mastercardCryptoFormats addObject:MCSCryptoFormatICC];
                break;
            case MCCCryptogramUCAF:
                [mastercardCryptoFormats addObject:MCSCryptoFormatUCAF];
                break;
            case MCCCryptogramTAVV:
                [visaCryptoFormats addObject:MCSCryptoFormatTVV];
                break;
        }
    }
    
    return @[mastercardCryptoOptions, visaCryptoOptions];
}

@end
