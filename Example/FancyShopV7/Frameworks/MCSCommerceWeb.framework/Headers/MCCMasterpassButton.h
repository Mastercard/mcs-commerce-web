//
//  MCCMasterpassButton.h
//
//  Created by Gajera, Semal on 2/12/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * MCCMasterpassButton implements a "Pay with masterpass" button on device's touch screen. This class restrict the use of UIButton methods to set title, image and also restrict to add event on UIButton.
 
 Overview:
 
 This class provides API to add itself to specified super view. It also handle the object that implement MCCTransactionDataSource protocol.
 
 @date 2016-02-17
 
 */

@interface MCCMasterpassButton : UIButton

/**
 *
 * Adds button on the view.
 *
 * This method will add the object of MCCMasterpassButton on the passed UIView object.
 *
 * @param superView
    UIView object on which button will be added.
 *
 */
- (void)addButtonToview:(UIView* _Nonnull) superView;

@end
