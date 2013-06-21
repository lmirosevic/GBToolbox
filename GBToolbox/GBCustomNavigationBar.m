//
//  GBCustomNavigationBar.m
//  Xmas List
//
//  Created by Luka Mirosevic on 29/11/2012.
//  Copyright (c) 2012 Goonbee. All rights reserved.
//

#import "GBCustomNavigationBar.h"

@interface GBCustomNavigationBar ()

@property (assign, nonatomic) CGFloat   navBarHeight;

@end

@implementation GBCustomNavigationBar

#pragma mark - life

static CGFloat _defaultNavBarHeightForClass = 44;

+(Class)navigationBarClassWithHeight:(CGFloat)height {
    _defaultNavBarHeightForClass = height;
    
    return [self class];
}

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.navBarHeight = _defaultNavBarHeightForClass;
    }
    
    return self;
}

-(id)initWithNavBarHeight:(CGFloat)height {
    if (self = [self init]) {
        self.navBarHeight = height;
    }
    
    return self;
}

#pragma mark - customizations

-(CGSize)sizeThatFits:(CGSize)size {
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    
    return CGSizeMake(frame.size.width , self.navBarHeight);
}

@end
