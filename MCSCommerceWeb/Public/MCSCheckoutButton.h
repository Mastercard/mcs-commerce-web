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
#import "MCCMasterpassButton.h"

/**
 * MCSCheckoutButton implements a button to initiate checkout. This class restricts the use of UIButton methods
 * to encapsulate the functionality of calling checkout.
 */
@interface MCSCheckoutButton : MCCMasterpassButton

/** constant width of the checkout button **/
extern CGFloat const kCheckoutButtonWidth;

/** constant height of the checkout button **/
extern CGFloat const kCheckoutButtonHeight;

/**
 *
 * Adds button on the view.
 *
 * This method will add the object of MCSCheckoutButton on the passed UIView object.
 *
 * @param superView UIView object on which button will be added.
 *
 */
- (void)addButtonToView:(UIView* _Nonnull) superView;

@end