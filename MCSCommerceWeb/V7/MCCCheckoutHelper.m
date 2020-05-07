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

#import "MCCCheckoutHelper.h"
#import "MCCCheckoutRequest.h"
#import "MCCConfiguration.h"
#import "MCSCheckoutRequest.h"
#import "MCSConfiguration.h"
#import "MCCMerchantConstants.h"
#import "MCCMerchantConstants+Private.h"
#import "MCFEnvironmentConfiguration.h"

@implementation MCCCheckoutHelper

+ (MCSCheckoutRequest *)requestWithRequest:(MCCCheckoutRequest *)request {
    MCSCheckoutRequest *newRequest = [[MCSCheckoutRequest alloc] init];
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

+ (MCSConfiguration *)configurationWithConfiguration:(MCCConfiguration *)configuration {
    NSSet<MCSCardType> *allowedCardTypes = [self cardTypesWithCardTypes:configuration.allowedCardTypes];
    
    return [[MCSConfiguration alloc] initWithLocale:configuration.locale
                                         checkoutId:configuration.checkoutId
                                            checkoutUrl:configuration.checkoutUrl
                                     callbackScheme:configuration.callbackScheme
                                   allowedCardTypes:allowedCardTypes
                           presentingViewController:configuration.presentingViewController];
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
    mastercardCryptoOptions.format = mastercardCryptoFormats;
    visaCryptoOptions.format = visaCryptoFormats;
    
    return @[mastercardCryptoOptions, visaCryptoOptions];
}

@end
