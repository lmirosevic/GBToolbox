//
//  GBAlertBadgeView.m
//  Russia
//
//  Created by Luka Mirosevic on 01/07/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import "GBAlertBadgeView.h"

static CGPoint const kDefaultOffset =               (CGPoint){0, 0};
static CGFloat const kDefaultHeight =               20;
static CGFloat const kDefaultHorizontalPadding =    4;
static BOOL const kDefaultHidesWhenCountZero =      NO;
#define kDefaultFont                                [UIFont fontWithName:@"Helvetica" size:12]
#define kDefaultTextColor                           [UIColor whiteColor];

@interface GBAlertBadgeView ()

@property (strong, nonatomic) UIImageView           *backgroundImageView;
@property (strong, nonatomic) UILabel               *label;

@property (strong, nonatomic) UIView                *observedView;

@property (assign, nonatomic) CGPoint               offset;

@end

@implementation GBAlertBadgeView

#pragma mark - custom accessors

-(void)setBadgeCount:(NSInteger)badgeCount {
    self.badgeText = [NSString stringWithFormat:@"%ld", (long)badgeCount];
}

-(NSInteger)badgeCount {
    return [self.badgeText integerValue];
}

-(void)setBadgeText:(NSString *)badgeText {
    self.label.text = badgeText;
    
    [self _handleAutoHiding];
    [self _resizeBadge];
    [self _repositionBadge];
}

-(NSString *)badgeText {
    return self.label.text;
}

-(void)setFont:(UIFont *)font {
    self.label.font = font;
    
    [self _resizeBadge];
    [self _repositionBadge];
}

-(UIFont *)font {
    return self.label.font;
}

-(void)setTextColor:(UIColor *)textColor {
    self.label.textColor = textColor;
}

-(UIColor *)textColor {
    return self.label.textColor;
}
    
-(void)setBackgroundImage:(UIImage *)backgroundImage {
    self.backgroundImageView.image = backgroundImage;
}

-(UIImage *)backgroundImage {
    return self.backgroundImageView.image;
}

-(void)setHorizontalPadding:(CGFloat)horizontalPadding {
    _horizontalPadding = horizontalPadding;
    
    [self _resizeBadge];
    [self _repositionBadge];
}

-(void)setHeight:(CGFloat)height {
    _height = height;
    
    [self _resizeBadge];
    [self _repositionBadge];
}

#pragma mark - convenience

+(GBAlertBadgeView *)badgeWithHeight:(CGFloat)height font:(UIFont *)font textColor:(UIColor *)textColor backgroundImage:(UIImage *)backgroundImage horizontalPadding:(CGFloat)horizontalPadding {
    return [[self alloc] initWithHeight:height font:font textColor:textColor backgroundImage:backgroundImage horizontalPadding:horizontalPadding];
}

#pragma mark - API

-(void)syncFrameWithView:(UIView *)view offset:(CGPoint)offset {
    //remove old KVO
    [self _removeKVO];
    
    //add KVO
    [self _addKVOForView:view withOffset:offset];
    
    //fire it off once for good measure
    [self  _repositionBadge];
}

-(void)stopSyncingFrame {
    [self _removeKVO];
}

#pragma mark - life

-(id)initWithHeight:(CGFloat)height font:(UIFont *)font textColor:(UIColor *)textColor backgroundImage:(UIImage *)backgroundImage horizontalPadding:(CGFloat)horizontalPadding {
    if (self = [super init]) {
        [self _init];
        
        self.font = font;
        self.textColor = textColor;
        self.backgroundImage = backgroundImage;
        self.height = height;
        self.horizontalPadding = horizontalPadding;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
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
    //common config
    self.userInteractionEnabled = NO;
    
    //bg image view
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    self.backgroundImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backgroundImageView];
    
    //label
    self.label = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = kDefaultFont;
    self.label.textColor = kDefaultTextColor;
    self.label.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.label];
    
    //defaults
    self.offset = kDefaultOffset;
    self.height = kDefaultHeight;
    self.horizontalPadding = kDefaultHorizontalPadding;
    self.font = kDefaultFont;
    self.textColor = kDefaultTextColor;
    self.hidesWhenCountZero = kDefaultHidesWhenCountZero;
}

-(void)dealloc {
    self.backgroundImageView = nil;
    self.label = nil;
    
    [self _removeKVO];
}

#pragma mark - KVO

void *kFrameObserver = &kFrameObserver;

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == kFrameObserver) {
        [self _repositionBadge];
    }
}

#pragma mark - util

-(void)_handleAutoHiding {
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

-(void)_resizeBadge {
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            [self _width],
                            [self _height]);
}

-(void)_repositionBadge {
    if (self.observedView) {
        self.frame = CGRectMake(self.observedView.frame.origin.x + self.observedView.frame.size.width + self.offset.x,
                                self.observedView.frame.origin.y + self.observedView.frame.size.height * 0.5 - self.frame.size.height * 0.5 + self.offset.y,
                                self.frame.size.width,
                                self.frame.size.height);
    }
}

-(CGFloat)_width {    
    CGFloat prelimWidth = ceilf([self.badgeText sizeWithAttributes:@{
        NSFontAttributeName: self.font
    }].width);
    
    return prelimWidth + self.horizontalPadding * 2;
}

-(CGFloat)_height {
    return self.height;
}

-(void)_addKVOForView:(UIView *)view withOffset:(CGPoint)offset {
    [view addObserver:self forKeyPath:@"frame" options:0 context:kFrameObserver];
    self.observedView = view;
}

-(void)_removeKVO {
    [self.observedView removeObserver:self forKeyPath:@"frame" context:kFrameObserver];
    self.observedView = nil;
}

@end
