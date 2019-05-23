/*
 * Copyright © 2019 Mastercard. All rights reserved.
 ============================================================*/

/**
 * CryptoOptions is used to determine the compatible Mastercard and
 * Visa formats for cryptograms for tokenized transactions.
 *
 * @author Amit Somani
 */
	

#import <Foundation/Foundation.h>

@interface MCSCryptoOptions : NSObject

/** card network generating the cryptogram (e.g., master, visa) **/
@property (nonatomic, copy, readwrite, nonnull) NSString *cardType;

/** support cryptogram format for the provided cardType **/
@property (nonatomic, readwrite, nonnull) NSSet<NSString *> *format;

@end
