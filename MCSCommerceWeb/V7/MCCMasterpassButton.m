//
//  MCCMasterpassButton.m
//  MobileCheckoutMerchantLib
//
//  Created by Gajera, Semal on 2/12/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import "MCCMasterpassButton+Private.h"
#import "MCCMerchant.h"
#import "MCCMerchantConstants+Private.h"


//Masterpass Button
static NSString * const kMasterpassButtonAccessibilityIdentifier = @"masterpassCheckoutButton";
NSNotificationName const MasterPassButtonImageDidAttachNotification = @"masterpassButtonImage";

@implementation MCCMasterpassButton

- (instancetype) init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype) initWithFrame:(CGRect)frame {
   if (self = [super initWithFrame:frame]) {
       [self commonInit];
    }
    
    return self;
}

/*
 * Overrided defult UIButton method to prevent the method call for MCCMasterpassButton
 */

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    //override default behavior to do nothing. Prevents loading from storyboard.
    return self;
}

/*
 * Overrided defult UIButton method to prevent the method call for MCCMasterpassButton
 */
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    //override default behavior to do nothing
}

/*
 * Overrided defult UIButton method to prevent the method call for MCCMasterpassButton
 */
- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    //override default behavior to do nothing
}

/*
 * Common initialization for MCCMasterpassButton. Adds hight and width constraints. Adds set target for tap event. Sets MCCMasterpassButton image.
 */
- (void)commonInit {
    
    //Adding height and width constraints
    
    NSLayoutConstraint * width = [NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:0
                                                             multiplier:1.0
                                                               constant:kMasterpassButtonWidth];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:0
                                                             multiplier:1.0
                                                               constant:kMasterpassButtonHeight];
    [self addConstraints:@[width, height]];
    
    self.accessibilityIdentifier = kMasterpassButtonAccessibilityIdentifier;
    
    // Adding touch up inside event
    // To Do: Check if this create circular reference problem or not
    [super addTarget:self action:@selector(masterpassButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self configureMasterpassButton];
}

/*
 * Set button image based on the checkout flow
 */
- (void) configureMasterpassButton {
    [self setDefaultMasterPassImage];
}

/*
 * Set Default masterpass image
 */
- (void) setDefaultMasterPassImage {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *masterpassImage = [UIImage imageNamed:kMasterPassDefaultButtonImageName inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
        [super setImage:masterpassImage forState:UIControlStateNormal];
		[[NSNotificationCenter defaultCenter] postNotificationName:MasterPassButtonImageDidAttachNotification object:self userInfo:nil];
    });
}

- (void)addButtonToview:(UIView* _Nonnull) superView {
    
    [superView addSubview:self];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Set button horizontal and vertical center in super view
    
    NSLayoutConstraint *centerVertical = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    NSLayoutConstraint *centerHorizontal = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [superView addConstraints:@[centerVertical, centerHorizontal]];
}

/*
 * Tapping Masterpass Button will checkout using MCCMerchant with the provided delegate.
 */
- (void)masterpassButtonTapped:(id) sender {
    [MCCMerchant checkoutWithDelegate:self.delegate];
}

@end
