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

#import "MCSActivityIndicatorView.h"

@interface MCSActivityIndicatorView()

@property (nonatomic, strong) UIActivityIndicatorView *indicator;
//@property (nonatomic, strong) UIVisualEffectView *vibrancyView;
//@property (nonatomic, strong) UIBlurEffect *blurEffect;
@property (nonatomic, strong) UILabel *label;

@end

@implementation MCSActivityIndicatorView

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.title = title;
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.label = [[UILabel alloc] init];
        self.hidden = YES;
        
        [_label setText:title];
        
        [self addSubview:_indicator];
        [self addSubview:_label];
        
        [_indicator startAnimating];
    }
    
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    UIView *superview = self.superview;
    CGFloat width = superview.frame.size.width / 2.9;
    CGFloat height = 100.0;
    CGFloat indicatorSize = 50;
    
    self.frame = CGRectMake(superview.frame.size.width / 2 - width / 2, superview.frame.size.height / 2 - height / 2, width, height);
    
    self.indicator.frame = CGRectMake(width / 2 - indicatorSize / 2, height / 4 - indicatorSize / 2 + 5, indicatorSize, indicatorSize);
    
    self.layer.cornerRadius = 8.0;
    self.layer.masksToBounds = true;
    self.layer.backgroundColor = [[UIColor lightGrayColor] CGColor];
    self.layer.zPosition = FLT_MAX;
    
    self.label.enabled = YES;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.frame = CGRectMake(width / 4 , height / 4 + 3 + indicatorSize / 2 + 10, width / 2 + 10, 30);
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont boldSystemFontOfSize:16];
}

- (void)show {
    [self setHidden:NO];
}

- (void)hide {
    [self setHidden:YES];
}

@end
