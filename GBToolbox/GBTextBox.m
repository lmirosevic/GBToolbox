//
//  GBTextBox.m
//  Russia
//
//  Created by Luka Mirosevic on 05/07/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import "GBTextBox.h"

static CGFloat const kDefaultIconVerticalOffset =       0;
static CGFloat const kDefaultIconLeftMargin =           0;
static CGFloat const kDefaultRightIconVerticalOffset =  0;
static CGFloat const kDefaultRightIconRightMargin =     0;
static NSTextAlignment const kDefaultTextAlignment =    NSTextAlignmentCenter;
static UIEdgeInsets const kDefaultTextPadding =         (UIEdgeInsets){0, 0, 0, 0};
static CGSize const kDefaultTextShadowOffset =          (CGSize){0, 0};
#define kDefaultFont                                    [UIFont fontWithName:@"HelveticaNeue-Medium" size:12]
#define kDefaultColor                                   [UIColor colorWithWhite:0.8 alpha:1]
#define kDefaultShadowColor                             [UIColor clearColor];


@interface GBTextBox ()

@property (strong, nonatomic) UIImageView               *iconImageView;
@property (strong, nonatomic) UIImageView               *rightIconImageView;
@property (strong, nonatomic) UIImageView               *backgroundImageView;
@property (strong, nonatomic) UILabel                   *textLabel;

@property (assign, nonatomic) CGFloat                   previousHeight;

@end

@implementation GBTextBox

#pragma mark - ca

-(void)setIcon:(UIImage *)icon {
    self.iconImageView.image = icon;
    
    [self _handleIconGeometry];
}

-(UIImage *)icon {
    return self.iconImageView.image;
}

-(void)setRightIcon:(UIImage *)rightIcon {
    self.rightIconImageView.image = rightIcon;
    
    [self _handleRightIconGeometry];
}

-(UIImage *)rightIcon {
    return self.rightIconImageView.image;
}

-(void)setBackgroundImage:(UIImage *)backgroundImage {
    self.backgroundImageView.image = backgroundImage;
}

-(UIImage *)backgroundImage {
    return self.backgroundImageView.image;
}

-(void)setIconLeftMargin:(CGFloat)iconLeftMargin {
    _iconLeftMargin = iconLeftMargin;
    
    [self _handleIconGeometry];
}

-(void)setIconVerticalOffset:(CGFloat)iconVerticalOffset {
    _iconVerticalOffset = iconVerticalOffset;
    
    [self _handleIconGeometry];
}

-(void)setRightIconRightMargin:(CGFloat)rightIconRightMargin {
    _rightIconRightMargin = rightIconRightMargin;
    
    [self _handleRightIconGeometry];
}

-(void)setRightIconVerticalOffset:(CGFloat)rightIconVerticalOffset {
    _rightIconVerticalOffset = rightIconVerticalOffset;
    
    [self _handleRightIconGeometry];
}

-(void)setTextColor:(UIColor *)textColor {
    self.textLabel.textColor = textColor;
}

-(UIColor *)textColor {
    return self.textLabel.textColor;
}

-(void)setTextShadowColor:(UIColor *)textShadowColor {
    self.textLabel.shadowColor = textShadowColor;
}

-(UIColor *)textShadowColor {
    return self.textLabel.shadowColor;
}

-(void)setTextShadowOffset:(CGSize)textShadowOffset {
    self.textLabel.shadowOffset = textShadowOffset;
}

-(CGSize)textShadowOffset {
    return self.textLabel.shadowOffset;
}

-(void)setFont:(UIFont *)font {
    self.textLabel.font = font;
    
    [self _handleFrameGeometry];
}

-(UIFont *)font {
    return self.textLabel.font;
}

-(void)setText:(NSString *)text {
    self.textLabel.text = text;
    
    [self _handleFrameGeometry];
}

-(NSString *)text {
    return self.textLabel.text;
}

-(void)setTextAlignment:(NSTextAlignment)textAlignment {
    self.textLabel.textAlignment = textAlignment;
    
    [self _handleFrameGeometry];
}

-(NSTextAlignment)textAlignment {
    return self.textLabel.textAlignment;
}

-(void)setTextPadding:(UIEdgeInsets)textPadding {
    _textPadding = textPadding;
    
    [self _handleFrameGeometry];
}

#pragma mark - life

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
    self.backgroundColor = [UIColor clearColor];
    
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    self.backgroundImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backgroundImageView];
    
    self.iconImageView = [UIImageView new];
    self.iconImageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    self.iconImageView.contentMode = UIViewContentModeCenter;
    self.iconImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.iconImageView];
    
    self.rightIconImageView = [UIImageView new];
    self.rightIconImageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    self.rightIconImageView.contentMode = UIViewContentModeCenter;
    self.rightIconImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.rightIconImageView];
    
    self.textLabel = [UILabel new];
    self.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.textLabel.numberOfLines = 0;
    self.textLabel.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.textLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.textLabel];
    
    //defaults
    self.iconVerticalOffset = kDefaultIconVerticalOffset;
    self.iconLeftMargin = kDefaultIconLeftMargin;
    self.font = kDefaultFont;
    self.textColor = kDefaultColor;
    self.textShadowColor = kDefaultShadowColor;
    self.textShadowOffset = kDefaultTextShadowOffset;
    self.textAlignment = kDefaultTextAlignment;
    self.textPadding = kDefaultTextPadding;
}

#pragma mark - API

-(void)recalculateHeight {
    [self _handleFrameGeometry];
}

#pragma mark - util

-(void)_handleIconGeometry {
    self.iconImageView.frame = CGRectMake(self.iconLeftMargin,
                                          (self.bounds.size.height - self.icon.size.height) * 0.5 + self.iconVerticalOffset,
                                          self.icon.size.width,
                                          self.icon.size.height);
}

-(void)_handleRightIconGeometry {
    self.rightIconImageView.frame = CGRectMake(self.bounds.size.width - self.rightIcon.size.width - self.rightIconRightMargin,
                                               (self.bounds.size.height - self.rightIcon.size.height) * 0.5 + self.rightIconVerticalOffset,
                                               self.rightIcon.size.width,
                                               self.rightIcon.size.height);
}

-(void)_handleFrameGeometry {
    //calculate the new height
    CGFloat newLabelHeight = [self _requiredLabelHeight];
    CGFloat newHeight = newLabelHeight + (self.textPadding.top + self.textPadding.bottom);
    
    //commit the new height
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            newHeight);
    
    //resize and reposition the label (which is based on our width)
    self.textLabel.frame = CGRectMake(self.textPadding.left,
                                      self.textPadding.top,
                                      [self _requiredLabelWidth],
                                      newLabelHeight);
    
    //update the icon too, sometimes the autoresizing mask fails if we started from a zero or negative height
    [self _handleIconGeometry];
    
    //let the delegate know if we changed our height
    if (self.previousHeight != newHeight) {
        if ([self.delegate respondsToSelector:@selector(textBox:didChangeHeightFrom:to:)]) {
            [self.delegate textBox:self didChangeHeightFrom:self.previousHeight to:newHeight];
        }
        
        //remember it so we can check if its changed in the future
        self.previousHeight = newHeight;
    }
}

-(CGFloat)_requiredLabelHeight {
    CGSize labelSize = [self.textLabel sizeThatFits:CGSizeMake([self _requiredLabelWidth],
                                                               CGFLOAT_MAX)];
    
    return labelSize.height;
}

-(CGFloat)_requiredLabelWidth {
    return self.bounds.size.width - (self.textPadding.left + self.textPadding.right);
}

@end
