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

#import <XCTest/XCTest.h>
#import "MCCSVGImage.h"

@interface MCCSVGImageTests : XCTestCase

@property(nonatomic, strong) NSData  *contentData;
@property(nonatomic, assign, readwrite) CGSize  originalSize;
@property(nonatomic, strong, readwrite) UIImage *image;
@property(nonatomic, strong) SvgCompletionBlock svgCompletionBlock;
typedef void (^WebViewCompletionBlock)(UIWebView * __nullable webView, NSError * __nullable error);

@end

@interface MCCSVGImage (Test)

- (void)initWithXMLData:(NSData *)data andSize:(CGSize)imageViewSize;
- (CGSize)calulateImageSizeBasedOnSizeToFit:(CGSize)imageSize andImageViewSize:(CGSize)imageViewSize;
- (void)loadWebViewWithXMLData:(NSData *)data size:(CGSize)size completionBlock:(WebViewCompletionBlock)completionBlock;
@end

@implementation MCCSVGImageTests

-(void)testInitWithXmlDataAndSize{

    NSString * test = [NSString stringWithFormat:@"myfile.txt"];
    NSData *myData = [[NSData alloc] initWithContentsOfFile:((void)(@"%@"), test)];
    MCCSVGImage *image =[[MCCSVGImage alloc]init];
    [image initWithXMLData:myData andSize:CGSizeMake(14, 14)];
    XCTAssertTrue(_contentData == myData, @"data should be the same");
}

-(void)testInit{

    MCCSVGImage *svgImage = [[MCCSVGImage alloc] init];
    XCTAssertTrue([svgImage isKindOfClass:[MCCSVGImage class]], @"avgImage should be of type MCCSVGImage class");
}

-(void)imageWithContentsOfURL{

    MCCSVGImage *image =[[MCCSVGImage alloc]init];
    NSURL *url = [[NSURL alloc] initWithString:@"https://www.google.com"];
    [image imageWithContentsOfURL:url andSize:CGSizeMake(14, 14) completionBlock:^(UIImage * _Nullable image, NSError * _Nullable error){
        XCTAssertNotNil(image);
        XCTAssertNil(error);
    }];
}

-(void)testImageWithData{

    MCCSVGImage *image =[[MCCSVGImage alloc]init];
    NSData *data= [NSData data];
    [image imageWithData:data andSize: CGSizeMake(14, 14) completionBlock:^(UIImage * _Nullable image, NSError * _Nullable error) {
        XCTAssertNotNil(image);
        XCTAssertNil(error);
    }];
}

-(void)testCaculateImageSize{
    MCCSVGImage *image =[[MCCSVGImage alloc]init];
    CGSize calculatedSize = [image calulateImageSizeBasedOnSizeToFit:CGSizeMake(14, 14) andImageViewSize:CGSizeMake(15, 15)];
    XCTAssertTrue(calculatedSize.width == 15.000, @"data should be the same");
    XCTAssertTrue(calculatedSize.height == 15.000, @"data should be the same");
}

-(void)testLoadWebViewWithXMLData{
    
    MCCSVGImage *image =[[MCCSVGImage alloc]init];
    NSString * test = [NSString stringWithFormat:@"myfile.txt"];
    NSData *myData = [[NSData alloc] initWithContentsOfFile:((void)(@"%@"), test)];
    [image loadWebViewWithXMLData:myData size:CGSizeMake(15, 15) completionBlock:^(UIWebView * __nullable webView, NSError * __nullable error){
        XCTAssertNotNil(webView);
        XCTAssertNil(error);
    }];
}

@end
