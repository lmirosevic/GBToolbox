//
//  GBAlertBadge.h
//  GBToolBox
//
//  Created by Luka Mirosevic on 10/10/2016.
//  Copyright © 2016 Goonbee e.U. All rights reserved.
//

#import "GBAlertBadge.h"

#import <QuartzCore/QuartzCore.h>

#import "GBMacros_iOS.h"
#import "GBMacros_Common.h"

static BOOL const kDefaultHidesWhenCountZero =                  NO;
static BOOL const kDefaultClipsToPillShape =                    YES;

@interface GBAlertBadge ()

@property (strong, nonatomic) UIImageView                       *backgroundImageView;
@property (strong, nonatomic) UILabel                           *label;
@property (strong, nonatomic) NSArray<NSLayoutConstraint *>     *paddingConstraints;

@end

@implementation GBAlertBadge

#pragma mark - CA

- (void)setClipsToPillShape:(BOOL)clipsToPillShape {
    _clipsToPillShape = clipsToPillShape;
    
    [self _handleCornerRadius];
}

- (void)setBadgeCount:(NSInteger)badgeCount {
    self.badgeText = [NSString stringWithFormat:@"%ld", (long)badgeCount];
}

- (NSInteger)badgeCount {
    return [self.badgeText integerValue];
}

- (void)setBadgeText:(NSString *)badgeText {
    self.label.text = badgeText;
    
    [self _handleAutoHiding];
}

- (NSString *)badgeText {
    return self.label.text;
}

- (void)setFont:(UIFont *)font {
    self.label.font = font;
}

- (UIFont *)font {
    return self.label.font;
}

- (void)setTextColor:(UIColor *)textColor {
    self.label.textColor = textColor;
}

- (UIColor *)textColor {
    return self.label.textColor;
}
    
- (void)setBackgroundImage:(UIImage *)backgroundImage {
    self.backgroundImageView.image = backgroundImage;
}

- (UIImage *)backgroundImage {
    return self.backgroundImageView.image;
}

- (void)setPadding:(UIEdgeInsets)padding {
    self.paddingConstraints[0].constant = padding.top;
    self.paddingConstraints[1].constant = padding.left;
    self.paddingConstraints[2].constant = padding.bottom;
    self.paddingConstraints[3].constant = padding.right;
}

- (UIEdgeInsets)padding {
    return UIEdgeInsetsMake(
        self.paddingConstraints[0].constant,
        self.paddingConstraints[1].constant,
        self.paddingConstraints[2].constant,
        self.paddingConstraints[3].constant
    );
}

#pragma mark - Overrides

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self _handleCornerRadius];
}

#pragma mark - API

+ (instancetype)badgeWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor padding:(UIEdgeInsets)padding {
    AssertParameterNotNil(font);
    AssertParameterNotNil(textColor);
    AssertParameterNotNil(backgroundColor);
    
    GBAlertBadge *badge = [[self alloc] initWithFont:font textColor:textColor backgroundImage:nil padding:padding];
    badge.clipsToPillShape = YES;
    badge.backgroundColor = backgroundColor;
    
    return badge;
}

+ (instancetype)badgeWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundImage:(UIImage *)backgroundImage padding:(UIEdgeInsets)padding {
    return [[self alloc] initWithFont:font textColor:textColor backgroundImage:backgroundImage padding:padding];
}

- (instancetype)initWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundImage:(UIImage *)backgroundImage padding:(UIEdgeInsets)padding {
    AssertParameterNotNil(font);
    AssertParameterNotNil(textColor);
    
    if (self = [super init]) {
        // defaults
        _hidesWhenCountZero = kDefaultHidesWhenCountZero;
        _clipsToPillShape = kDefaultClipsToPillShape;
        
        // common config
        self.userInteractionEnabled = NO;
        
        // bg image view
        UIImageView *backgroundImageView = AutoLayout([UIImageView new]);
        backgroundImageView.image = backgroundImage;
        backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        backgroundImageView.contentMode = UIViewContentModeScaleToFill;
        backgroundImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:backgroundImageView];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backgroundImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroundImageView)]];// full width
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backgroundImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroundImageView)]];// full height
        self.backgroundImageView = backgroundImageView;
        
        // label
        UILabel *label = AutoLayout([UILabel new]);
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = font;
        label.textColor = textColor;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        // create our padding constraints, attach them to the view and keep a ref to them so that we can change them later.
        NSArray<NSLayoutConstraint *> *paddingConstraints = @[
            [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop     relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop      multiplier:1.0 constant:padding.top],
            [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft     multiplier:1.0 constant:padding.left],
            [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeBottom  relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom   multiplier:1.0 constant:-padding.bottom],
            [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight    multiplier:1.0 constant:-padding.right],
        ];
        [self addConstraints:paddingConstraints];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];// circle is never squashed (width >= height)
        self.paddingConstraints = paddingConstraints;
        self.label = label;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Cannot initialize this class with initWithCode:" userInfo:nil];
}

#pragma mark - Private

- (void)_handleAutoHiding {
    if (self.hidesWhenCountZero) {
        if (!self.badgeText ||
            [self.badgeText isEqualToString:@""] ||
            [self.badgeText isEqualToString:@"0"]) {
            self.hidden = YES;
        }
        else {
            self.hidden = NO;
        }
    }
    else {
        self.hidden = NO;
    }
}

- (void)_handleCornerRadius {
    if (self.clipsToPillShape) {
        self.layer.cornerRadius = self.bounds.size.height / 2.0;
        self.layer.masksToBounds = YES;
    } else {
        self.layer.cornerRadius = 0;
        self.layer.masksToBounds = NO;
    }
}

@end
