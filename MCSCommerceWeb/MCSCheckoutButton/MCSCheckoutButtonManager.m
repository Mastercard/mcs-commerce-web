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

#import <UIKit/UIKit.h>
#import <SVGKit/SVGKit.h>
#import "MCSCommerceWeb.h"
#import "MCSCheckoutButtonManager.h"
#import "MCSConfigurationManager.h"
#import "MCFEnvironmentConfiguration.h"
#import "MCSCheckoutButton+Private.h"
#import "MCCMerchantConstants+Private.h"

NSString *const kMasterPassDefaultButtonImage       = @"MasterpassButton";

@interface MCSCheckoutButtonManager()

@property(nonatomic, strong, nullable) UIImage *buttonImage;
@property(nonatomic, strong, nullable) NSError *svgImageError;

@end

@implementation MCSCheckoutButtonManager
static MCSCheckoutButtonManager *sharedManager = nil;
NSString *basePath = @"button/";

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        [sharedManager initialize];
    });
    
    return sharedManager;
}

- (MCSCheckoutButton *)checkoutButtonWithDelegate:(__autoreleasing id<MCSCheckoutDelegate>)delegate {
    MCSCheckoutButton *checkoutButton = [[MCSCheckoutButton alloc] init];
    
    [checkoutButton setDelegate:delegate];
    [checkoutButton setButtonImage:self.buttonImage];
    
    return checkoutButton;
}

- (void)initialize {
    NSLocale *locale = [MCSConfigurationManager sharedManager].configuration.locale;
    NSSet *allowedCardTypes = [MCSConfigurationManager sharedManager].configuration.allowedCardTypes;
    NSString *checkoutId = [MCSConfigurationManager sharedManager].configuration.checkoutId;
    NSURL *buttonUrl = [NSURL URLWithString:[MCFEnvironmentConfiguration sharedInstance].buttonImageHost];
    
    // Sort allowedCardTypes and concatenate values into String for unique hashing
    NSArray *allowedCardTypesArray = [NSArray arrayWithArray:[allowedCardTypes allObjects]];
    NSArray *sortedAllowedCardTypes = [allowedCardTypesArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSMutableString *cardTypesString = [[NSMutableString alloc] init];
    for (NSString *allowedCardType in sortedAllowedCardTypes) {
        [cardTypesString appendString:allowedCardType];
    }
    
    NSString *fileName = [NSString stringWithFormat:@"%lu%lu", [locale hash], [cardTypesString hash]];
    NSURL *saveUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    saveUrl = [saveUrl URLByAppendingPathComponent:fileName];
    
    //Check if image is cached
    NSData *buttonData = [NSData dataWithContentsOfFile:saveUrl.path];
    if (buttonData != nil) {
        UIImage *cacheImage = [UIImage imageWithData:buttonData];
        
        self.buttonImage = cacheImage;
    } else {
        // set default button image
        UIImage *defaultImg = [UIImage imageNamed:kMasterPassDefaultButtonImage inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
        self.buttonImage = defaultImg;
    }
    
    //Download image from URL
    NSURLComponents *components = [NSURLComponents componentsWithURL:buttonUrl resolvingAgainstBaseURL:YES];
    NSURLQueryItem *localeQueryItem = [[NSURLQueryItem alloc] initWithName:@"locale" value:locale.localeIdentifier];
    NSURLQueryItem *allowedCardsQueryItem = [[NSURLQueryItem alloc] initWithName:@"acceptedCardBrands" value:[allowedCardTypes.allObjects componentsJoinedByString:@","]];
    NSURLQueryItem *checkoutIdQueryItetm = [[NSURLQueryItem alloc] initWithName:@"checkoutId" value:checkoutId];
    
    [components setQueryItems:@[localeQueryItem, allowedCardsQueryItem, checkoutIdQueryItetm]];
    NSURLSession *session = [NSURLSession sharedSession];
    MCSCheckoutButtonManager * __weak weakSelf = self;

    [[session downloadTaskWithURL:components.URL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        SVGKImage* cacheImage = [SVGKImage imageWithContentsOfURL:location];
        NSData *imageData = UIImagePNGRepresentation(cacheImage.UIImage);
        
        if (imageData != nil) {
            NSError *svgImageError;
            [imageData writeToFile:saveUrl.path options:NSDataWritingAtomic error:&svgImageError];
            weakSelf.buttonImage = cacheImage.UIImage;
        }
        else {
            NSLog(@"Error: %@",[error localizedDescription]);
        }
        
    }] resume];
}

@end
