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

#import <netinet/in.h>
#import <Foundation/Foundation.h>

/**
 NetworkStatus, this enum is for different statuses based on the reachability of the internet
 */
typedef NS_ENUM(NSInteger, NetworkStatus) {
    NotReachable = 0,
    ReachableViaWiFi,
    ReachableViaWWAN
};

@interface MCSReachability : NSObject

/**
 Used to check the reachability of a given IP address.
 */
+ (instancetype _Nullable)reachabilityWithAddress:(const struct sockaddr *_Nullable)hostAddress;

/**
 Checks whether the default route is available.
 Should be used by applications that do not connect to a particular host.
 */
+ (instancetype _Nullable)reachabilityForInternetConnection;

/**
 @return NetworkStatus, the current status for reaching the internet
 */
- (NetworkStatus)currentReachabilityStatus;

/**
 Used to check if the internet connection is available on a device.
 If the error is nil, this means that the internet is active.
 
 @return NSError if the internet connection is not available.
 */
+ (NSError * _Nullable)isNetworkReachable;

@end


