//
//  MDSPrecheckoutDataRequest.h
//  MerchantServices
//
//  Created by Patel, Utkal on 4/3/18.
//  Copyright © 2018 Patel, Utkal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDSBaseServiceRequest.h"

@interface MDSPrecheckoutDataRequest : MDSBaseServiceRequest

//pairingId reprensts paring identifier whcih will be use to get precheckout data of user
@property (nonatomic, nonnull) NSString *pairingId;

@end
