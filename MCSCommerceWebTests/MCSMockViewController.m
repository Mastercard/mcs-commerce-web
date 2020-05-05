//
//  MockViewController.m
//  MCSCommerceWebTests
//
//  Created by Payne, Nathaniel on 4/22/20.
//  Copyright © 2020 Mastercard. All rights reserved.
//

#import "MCSMockViewController.h"

@interface MCSMockViewController ()

@end

@implementation MCSMockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    self.viewControllerPresented = viewControllerToPresent;
}

@end
