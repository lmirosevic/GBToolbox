//
//  GBRoundBadgeView.m
//  Russia
//
//  Created by Luka Mirosevic on 26/06/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import "GBRoundBadgeView.h"

#import <QuartzCore/QuartzCore.h>

@interface GBRoundBadgeView ()

@property (strong, nonatomic) UIImageView       *backgroundImageView;
@property (strong, nonatomic) UIImageView       *foregroundImageView;

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

-(void)setBackgroundImageMargin:(UIEdgeInsets)backgroundImageMargin {
    _backgroundImageMargin = backgroundImageMargin;
    
    [self _updateImageViewFrames];
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
    self.foregroundImageView = [UIImageView new];
    self.backgroundImageView = [UIImageView new];
    
    self.backgroundColor = [UIColor clearColor];
}

-(void)awakeFromNib {
    self.foregroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self _updateImageViewFrames];
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.foregroundImageView];
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
}

-(void)_updateClippingMask {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.bounds.origin.x + self.clippingMargin.left,
                                                                                 self.bounds.origin.y + self.clippingMargin.top,
                                                                                 self.bounds.size.width - (self.clippingMargin.left + self.clippingMargin.right),
                                                                                 self.bounds.size.height - (self.clippingMargin.top + self.clippingMargin.bottom))];
    CAShapeLayer *shapeMask = [CAShapeLayer new];
    shapeMask.frame = self.bounds;
    shapeMask.path = bezierPath.CGPath;
    self.layer.mask = shapeMask;
}

@end
