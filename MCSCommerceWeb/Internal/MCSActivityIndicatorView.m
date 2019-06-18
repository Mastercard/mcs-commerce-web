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
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation MCSActivityIndicatorView

- (instancetype)initWithTitle:(NSString *)title {
//    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    if (self = [super initWithEffect:blurEffect]) {
//        self.blurEffect = blurEffect;
    if (self = [super init]) {
        self.title = title;
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        self.vibrancyView = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:blurEffect]];
        self.label = [[UILabel alloc] init];
        self.cancelButton = [[UIButton alloc] init];
        
        [_label setText:title];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
//        [self.contentView addSubview:_vibrancyView];
//        [_vibrancyView.contentView addSubview:_indicator];
//        [_vibrancyView.contentView addSubview:_label];
        [self addSubview:_indicator];
        [self addSubview:_label];
        [self addSubview:_cancelButton];
        [_indicator startAnimating];
    }
    
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    UIView *superview = self.superview;
    CGFloat width = superview.frame.size.width / 2.3;
    CGFloat height = 150.0;
    
    self.frame = CGRectMake(superview.frame.size.width / 2 - width / 2, superview.frame.size.height / 2 - height / 2, width, height);
//    self.vibrancyView.frame = self.bounds;
    
    CGFloat indicatorSize = 50;
    self.indicator.frame = CGRectMake(width / 2 - indicatorSize / 2, height / 4 - indicatorSize / 2, indicatorSize, indicatorSize);
    
    self.layer.cornerRadius = 8.0;
    self.layer.masksToBounds = true;
    self.layer.backgroundColor = [[UIColor lightGrayColor] CGColor];
    
    self.label.enabled = YES;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.frame = CGRectMake(width / 4, height / 4 + indicatorSize / 2 + 5, width / 2, 30);
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont boldSystemFontOfSize:16];
    
    self.cancelButton.enabled = YES;
    self.cancelButton.frame = CGRectMake(width / 4, height / 4 + indicatorSize / 2 + 10 + 30 + 10, width / 2, 30);
    [self.cancelButton setTitleColor:self.tintColor forState:UIControlStateNormal];
}

- (void)setTargetForCancel:(id)target action:(SEL)action {
    [_cancelButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)show {
    self.hidden = false;
}

- (void)hide {
    self.hidden = true;
}


@end
