//
//  MCSActivityIndicator.m
//  MCSCommerceWeb
//
//  Created by Deasy, Bret on 6/13/19.
//  Copyright © 2019 Mastercard. All rights reserved.
//

#import "MCSActivityIndicatorView.h"

@interface MCSActivityIndicator()

@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation MCSActivityIndicator

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]]) {
        self.title = title;
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    
    return self;
}

@end
