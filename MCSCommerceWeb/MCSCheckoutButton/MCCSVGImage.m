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

#import "MCCSVGImage.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MCCMerchantConstants+Private.h"

typedef void (^WebViewCompletionBlock)(UIWebView * __nullable webView, NSError * __nullable error);

#pragma mark - Web View Utils

@interface MCCSVGWebView : UIWebView

@end

@implementation MCCSVGWebView

#pragma mark - UIWebview dealloc

- (void)dealloc {
    
    // Ref: http://www.codercowboy.com/code-uiwebview-memory-leak-prevention/
    [self stringByEvaluatingJavaScriptFromString:kWebViewJavaScriptEvaluation];
    [self loadHTMLString:kWebViewLoadEmptyHTML baseURL:nil];
    [self stopLoading];
    self.delegate = nil;
    self.dataDetectorTypes = UIDataDetectorTypeNone;
    [self removeFromSuperview];
}

@end

#pragma mark - SVG Info Object

@interface MCCSVGInfo:NSObject<NSXMLParserDelegate>

@property(nonatomic, strong) NSData *contentData;
@property(nonatomic, assign, readwrite) CGSize imageSize;

@end

@implementation MCCSVGInfo

- (instancetype)initWithXMLData:(NSData *)data {
    
    if (self = [super init]) {
        
        self.contentData = data;
        self.imageSize = CGSizeMake(-1.0, -1.0);
        [self parse];
    }
    return self;
}

#pragma mark - parse SVG image

- (void)parse {
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.contentData];
    parser.delegate = self;
    [parser parse];
}

#pragma mark NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:kParserEelementName]) {
        
        // Get size from width/height attribute
        NSString *widthString = attributeDict[kParserAttribureWidth];
        NSString *heightString = attributeDict[kParserAttribureHeight];
        if (widthString && heightString) {
            
            CGFloat width = [widthString doubleValue];
            CGFloat height = [heightString doubleValue];
            if (width >= 0 && height >= 0) {
                
                self.imageSize = CGSizeMake(width, height);
            }
        }
        // End parsing
        [parser abortParsing];
    }
}

@end

#pragma mark - fetch

@interface MCCSVGImage()

@property(nonatomic, strong) NSData  *contentData;
@property(nonatomic, assign, readwrite) CGSize  originalSize;
@property(nonatomic, strong, readwrite) UIImage *image;
@property(nonatomic, strong) SvgCompletionBlock svgCompletionBlock;

@end

@implementation MCCSVGImage

- (instancetype) init {
    
    
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMemoryWarning:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.contentData=nil;
    self.image=nil;
}

- (void)imageWithContentsOfURL:(NSURL *)url andSize:(CGSize)imageViewSize completionBlock:(SvgCompletionBlock)completionBlock {
    
    [self imageWithData:[NSData dataWithContentsOfURL:url] andSize:imageViewSize completionBlock:completionBlock];
}

- (void)imageWithData:( NSData * _Nonnull)data andSize:(CGSize)imageViewSize completionBlock:(__nonnull SvgCompletionBlock)completionBlock{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.svgCompletionBlock = completionBlock;
        [self initWithXMLData:data andSize:imageViewSize];
    });
}

/*
 * Method for handling image data. Loads xml image data in web view.
 * @param data NSData xml data
 */
- (void)initWithXMLData:(NSData *)data andSize:(CGSize)imageViewSize {
    
    self.contentData=data;
    
    MCCSVGInfo *svgInfo = [[MCCSVGInfo alloc] initWithXMLData:self.contentData];
    //self.originalSize = svgInfo.imageSize;
    
    self.originalSize = [self calulateImageSizeBasedOnSizeToFit:svgInfo.imageSize andImageViewSize:imageViewSize];
    NSLog(@"original image size is:- %@ and imageView size is :- %@ and original size :- %@",NSStringFromCGSize(svgInfo.imageSize),NSStringFromCGSize(imageViewSize),NSStringFromCGSize(self.originalSize));

    if (self.originalSize.width < 0 || self.originalSize.height < 0) {
        
//        NSError *error = [NSError errorWithDomain:kMCCSVGErrorDomain code:kMCCSVGErrorCodeNoValidSVG userInfo:@{kMCCSVGError: MCCLocalizedString(@"mcc_err_no_valid_svg") }];
//        self.svgCompletionBlock(nil,error);
    } else {
     
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize finalSize = CGSizeMake(self.originalSize.width * scale, self.originalSize.height * scale);
        
        __weak __typeof(self)weakSelf = self;
        [self loadWebViewWithXMLData:data size:finalSize completionBlock:^(UIWebView * _Nullable webView, NSError * _Nullable error) {
            
            if (error) {
                
                weakSelf.svgCompletionBlock(nil, error);
            } else {
                
                UIGraphicsBeginImageContextWithOptions(finalSize, NO, 0.);
                [webView.layer renderInContext:UIGraphicsGetCurrentContext()];
                weakSelf.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                if (weakSelf.image) {
                    
                    weakSelf.svgCompletionBlock([weakSelf.image copy], nil);
                    weakSelf.contentData=nil;
                    weakSelf.image=nil;
                } else {
                    
//                    NSError *error = [NSError errorWithDomain:kMCCSVGErrorDomain code:kMCCSVGErrorCodeImageNotGenerated userInfo:@{kMCCSVGError:MCCLocalizedString(@"mcc_err_image_not_generated")}];
//                    weakSelf.svgCompletionBlock(nil, error);
                }
            }
        }];
    }
}

/*
 * Get original image size respective imageview size
 */
- (CGSize)calulateImageSizeBasedOnSizeToFit:(CGSize)imageSize andImageViewSize:(CGSize)imageViewSize {
    float imageViewAspectRatio = imageSize.width / imageSize.height;
    CGSize calculatedSize = imageViewSize;
    
    if (imageViewSize.width < imageViewSize.height) {
        calculatedSize.height = imageViewSize.width / imageViewAspectRatio;
    } else {
        calculatedSize.width = imageViewAspectRatio * imageViewSize.height;
    }
    
    return calculatedSize;
}

/*
 * Method for loading UIWebView with SVG image data
 * @param data NSData xml data
 * @param completionBlock WebViewCompletionBlock
 */
- (void)loadWebViewWithXMLData:(NSData *)data size:(CGSize)size completionBlock:(WebViewCompletionBlock)completionBlock{
    
    // Create UIWebView
    UIWebView *webView = [[MCCSVGWebView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    webView.opaque = NO;
    webView.scalesPageToFit = NO;
    webView.backgroundColor = [UIColor clearColor];
    
    // Add JS Method
    JSContext *jsContext = [webView valueForKeyPath:kJSContextKeyPath];
    if ([jsContext isKindOfClass:[jsContext class]]) {
        
        jsContext[kJSContextLoadedKey] = ^{

            dispatch_async(dispatch_get_main_queue(), ^{
               
                completionBlock(webView,nil);
            });
        };
    } else {
        
//        NSError *error = [NSError errorWithDomain:kMCCSVGErrorDomain code:kMCCSVGErrorCodeJSNotLoaded userInfo:@{kMCCSVGError:MCCLocalizedString(@"mcc_err_image_not_generated")}];
//        completionBlock(nil,error);
    }
    
    NSString *htmlString = [self htmlStringWithSize:size];
    [webView loadHTMLString:htmlString baseURL:nil];
}

/*
 * Method for loading UIWebView with SVG image data
 * @param size CGSize object
 * @return NSString object having html content
 */
- (NSString *)htmlStringWithSize:(CGSize)size {
    
    //Generate html string
    NSString *htmlStringTemplate = nil;
    NSString *htmlFile  = [[NSBundle bundleForClass:[self class]] pathForResource:kSVGHTMLFileName ofType:kSVGHTHMLFileType];
    htmlStringTemplate  = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    return [NSString stringWithFormat:htmlStringTemplate,
            size.width,
            [self.contentData base64EncodedStringWithOptions:0],
            size.width,
            size.height];
}

#pragma mark - Notification

- (void)didReceiveMemoryWarning:(NSNotification *)notification {
    
    self.image = nil;
//    NSError *error = [NSError errorWithDomain:kMCCSVGErrorDomain code:kMCCSVGErrorCodeMemoryWarning userInfo:@{kMCCSVGError:MCCLocalizedString(@"mcc_err_memory_warning")}];
//    self.svgCompletionBlock(nil, error);
}

@end

