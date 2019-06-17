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

#import "MCCMasterpassButton.h"
#import "MCCMerchant.h"
#import "MCCMerchantConstants+Private.h"

@implementation MCCMasterpassButton

- (void)addButtonToView:(UIView *)superView {
    [superView addSubview:self];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Set button horizontal and vertical center in super view
    
    NSLayoutConstraint *centerVertical = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    NSLayoutConstraint *centerHorizontal = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    [superView addConstraints:@[centerVertical, centerHorizontal]];
}

@end
