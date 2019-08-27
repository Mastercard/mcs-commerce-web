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

#import "MCSMockData.h"
#import "MCSMockFileLoader.h"

@implementation MCSMockData

+ (NSDictionary*)getRequestJsonFromAPIName:(NSString *)APIName {
    id jsonResponse = [MCSMockFileLoader loadJSONFromFileNamed:@"MockRequest"];
    return [jsonResponse valueForKey:APIName];
}

+ (NSDictionary*)getResponseJsonFromAPIName:(NSString *)APIName {
    id jsonResponse = [MCSMockFileLoader loadJSONFromFileNamed:@"MockResponse"];
    return [jsonResponse valueForKey:APIName];
}

+ (NSDictionary*)getErrorJsonFromAPIName:(NSString *)APIName {
    id jsonResponse = [MCSMockFileLoader loadJSONFromFileNamed:@"MockError"];
    return [jsonResponse valueForKey:APIName];
}

@end
