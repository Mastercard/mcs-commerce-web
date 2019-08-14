//
//  MCSActivityIndicatorViewTests.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 8/12/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

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
