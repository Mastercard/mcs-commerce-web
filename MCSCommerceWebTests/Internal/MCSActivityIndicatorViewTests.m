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

#import <XCTest/XCTest.h>
#import "MCSActivityIndicatorView.h"

@interface MCSActivityIndicatorViewTests : XCTestCase

@end

@implementation MCSActivityIndicatorViewTests

-(void)testInitWithTitle{
    
    MCSActivityIndicatorView *indicatorView = [[MCSActivityIndicatorView alloc] initWithTitle:@"MyTitle"];
    
    XCTAssertTrue([indicatorView.title isEqualToString:@"MyTitle"], @"title not set correctly");
    XCTAssertTrue(indicatorView.hidden, @"hidden is True");
    
}

-(void)testShow{
    
    MCSActivityIndicatorView *indicatorView = [[MCSActivityIndicatorView alloc] initWithTitle:@"MyTitle"];
    [indicatorView setHidden:NO];
    
     XCTAssertFalse(indicatorView.hidden, @"hidden is False");
    
}
    
-(void)testHide{
    
    MCSActivityIndicatorView *indicatorView = [[MCSActivityIndicatorView alloc] initWithTitle:@"MyTitle"];
    [indicatorView setHidden:YES];
    
    XCTAssertTrue(indicatorView.hidden, @"hidden is True");
}
    
@end
