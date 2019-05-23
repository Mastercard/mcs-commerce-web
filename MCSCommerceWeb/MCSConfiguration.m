/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

#import "MCSConfiguration.h"

@implementation MCSConfiguration

- (instancetype _Nonnull) initWithlocale:(NSLocale *)locale
                              checkoutId:(NSString *)checkoutId
                                     baseUrl:(NSString *)baseUrl
                                  callbackScheme:(NSString *)scheme {
    if (self = [super init]) {
        self.locale = locale;
        self.checkoutId = checkoutId;
        self.baseUrl = baseUrl;
        self.callbackScheme = scheme;
    }
    
    return self;
}


@end
