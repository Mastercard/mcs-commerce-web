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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 A block will provide UIImage object.
 
 @param image UIImage of SVG file
 @param error NSError object containing error in parsing the SVG data
 */
typedef void (^SvgCompletionBlock)(UIImage * __nullable image, NSError * __nullable error);

/**
 This class responsibility is to read and parse SVG file content and provide UIImage object for the provided SVG file path
 */
@interface MCCSVGImage : NSObject

/**
 This method is responsible for reading svg file, parse the content and create UIImage object out of the received SVG file path
 
 @param url NSURL object containing SVG file path
 @param completionBlock SvgCompletionBlock handler, this completion handler returns UIImage object or NSError object after reading SVG file
 */
- (void)imageWithContentsOfURL:(NSURL * _Nonnull)url andSize:(CGSize)imageViewSize completionBlock:(__nonnull  SvgCompletionBlock)completionBlock;

/**
 This method is responsible for reading image data file, parse the content and create UIImage object out of the received SVG file path
 
 @param data NSData object
 @param completionBlock SvgCompletionBlock handler, this completion handler returns UIImage object or NSError object after reading SVG file
 */
- (void)imageWithData:( NSData * _Nonnull)data andSize:(CGSize)imageViewSize completionBlock:(__nonnull SvgCompletionBlock)completionBlock;


@end
