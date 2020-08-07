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

#import "MCSCheckoutButton+Private.h"
#import "MCSConfigurationManager.h"

NSString * const kCheckoutButtonAccessibilityIdentifier = @"checkoutButton";

@implementation MCSCheckoutButton

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setAccessibilityIdentifier:kCheckoutButtonAccessibilityIdentifier];
        [super addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)addToSuperview:(UIView *)superview {
    [super addButtonToView:superview];
}

- (void)buttonTapped:(id)sender {
    //implement checkout on touch of button
    [self.delegate checkoutRequestForTransaction:^(MCSCheckoutRequest *checkoutRequest) {
        [[MCSCommerceWeb sharedManager] setDelegate:self.delegate];
        [[MCSCommerceWeb sharedManager] checkoutWithRequest:checkoutRequest];
    }];
}


#pragma mark Private Interface

- (void)setButtonImage:(UIImage *)image {
    [super setImage:image forState:UIControlStateNormal];
}

#pragma mark Override default behavior

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    //override default behavior to do nothing. Prevents loading from storyboard
    return nil;
}

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    //override default behavior to do nothing
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state {
    //override deafult behavior to do nothing
}

@end
