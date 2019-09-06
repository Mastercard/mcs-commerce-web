//
//  MCCMasterpassButtonTests.m
//  MCSCommerceWebTests
//
//  Created by Duan, Yizhu on 9/4/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCCMasterpassButton.h"

@interface MCCMasterpassButtonTests : XCTestCase

@end

@interface MCCMasterpassButton (testing)

- (void)addButtonToView:(UIView * _Nonnull)superView;

@end

@implementation MCCMasterpassButtonTests

-(void)testAddButtonToView{
    
    MCCMasterpassButton *button = [[MCCMasterpassButton alloc] init];
    UIView *superview = [UIView new];
    [button addButtonToView:superview];
    XCTAssertNotNil(button.superview, "Button should be added to View");
}

@end


