//
//  GBRoundBadgeView.m
//  Russia
//
//  Created by Luka Mirosevic on 26/06/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import "GBRoundBadgeView.h"

#import <QuartzCore/QuartzCore.h>
#import "GBUtility_iOS.h"

static UIViewContentMode const kDefaultForegroundImageContentMode =     UIViewContentModeScaleToFill;
static UIEdgeInsets const kDefaultClippingMargin =                      (UIEdgeInsets){0, 0, 0, 0};
static UIEdgeInsets const kDefaultBackgroundImageMargin =               (UIEdgeInsets){0, 0, 0, 0};
static UIEdgeInsets const kDefaultForegroundImageMargin =               (UIEdgeInsets){0, 0, 0, 0};

@interface GBRoundBadgeView ()

@property (strong, nonatomic) UIImageView                           *backgroundImageView;
@property (strong, nonatomic) UIImageView                           *foregroundImageView;

@end

@implementation GBRoundBadgeView

#pragma mark - custom accessors

-(void)setForegroundImage:(UIImage *)foregroundImage {
    self.foregroundImageView.image = foregroundImage;
}

-(UIImage *)foregroundImage {
    return self.foregroundImageView.image;
}

-(void)setBackgroundImage:(UIImage *)backgroundImage {
    self.backgroundImageView.image = backgroundImage;
}

-(UIImage *)backgroundImage {
    return self.backgroundImageView.image;
}

-(void)setClippingMargin:(UIEdgeInsets)clippingMargin {
    _clippingMargin = clippingMargin;
    
    [self _updateClippingMask];
}

-(void)setForegroundImageMargin:(UIEdgeInsets)foregroundImageMargin {
    _foregroundImageMargin = foregroundImageMargin;
    
    [self _updateImageViewFrames];
}

-(void)setBackgroundImageMargin:(UIEdgeInsets)backgroundImageMargin {
    _backgroundImageMargin = backgroundImageMargin;
    
    [self _updateImageViewFrames];
}

-(void)setForegroundImageContentMode:(UIViewContentMode)foregroundImageContentMode {
    self.foregroundImageView.contentMode = foregroundImageContentMode;
}

-(UIViewContentMode)foregroundImageContentMode {
    return self.foregroundImageContentMode;
}

#pragma mark - life

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self _init];
    }
    return self;
}

-(void)_init {
    self.backgroundColor = [UIColor clearColor];
    
    self.foregroundImageView = [UIImageView new];
    self.foregroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.backgroundImageView = [UIImageView new];
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.foregroundImageView];
    
    //defaults
    self.foregroundImageContentMode = kDefaultForegroundImageContentMode;
    self.clippingMargin = kDefaultClippingMargin;
    self.backgroundImageMargin = kDefaultBackgroundImageMargin;
    self.foregroundImageMargin = kDefaultForegroundImageMargin;
    
    [self _updateImageViewFrames];
}

#pragma mark - overrides

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self _updateClippingMask];
}

#pragma mark - util

-(void)_updateImageViewFrames {
    self.backgroundImageView.frame = CGRectMake(self.bounds.origin.x + self.backgroundImageMargin.left,
                                                self.bounds.origin.y + self.backgroundImageMargin.top,
                                                self.bounds.size.width - (self.backgroundImageMargin.left + self.backgroundImageMargin.right),
                                                self.bounds.size.height - (self.backgroundImageMargin.top + self.backgroundImageMargin.bottom));
    
    self.foregroundImageView.frame = CGRectMake(self.bounds.origin.x + self.foregroundImageMargin.left,
                                                self.bounds.origin.y + self.foregroundImageMargin.top,
                                                self.bounds.size.width - (self.foregroundImageMargin.left + self.foregroundImageMargin.right),
                                                self.bounds.size.height - (self.foregroundImageMargin.top + self.foregroundImageMargin.bottom));
    
    self.foregroundImageView.layer.mask = RoundClippingMaskInRectWithMargin(self.foregroundImageView.bounds, UIEdgeInsetsZero);
    self.backgroundImageView.layer.mask = RoundClippingMaskInRectWithMargin(self.backgroundImageView.bounds, UIEdgeInsetsZero);
}

-(void)_updateClippingMask {
    self.layer.mask = RoundClippingMaskInRectWithMargin(self.bounds, self.clippingMargin);
}

@end
