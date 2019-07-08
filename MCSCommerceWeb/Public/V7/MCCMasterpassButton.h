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

#import <UIKit/UIKit.h>

/**
 * MCCMasterpassButton implements a "Pay with masterpass" button on device's touch screen. This class restrict the use of UIButton methods to set title, image and also restrict to add event on UIButton.
 
 Overview:
 
 This class provides API to add itself to specified super view. It also handle the object that implement MCCTransactionDataSource protocol.
 
 @date 2016-02-17
 
 */

@interface MCCMasterpassButton : UIButton

/**
 * Add the Masterpass button to the given superview using pre-determined layout constraints.
 *
 * @param superView superview to which the button will be added
 */
- (void)addButtonToView:(UIView* _Nonnull)superView;

@end
