//
//  GBTextBox.m
//  Russia
//
//  Created by Luka Mirosevic on 05/07/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import "GBTextBox.h"

static GBTextBoxFlexibleDimension const kDefaultFlexibleDimension =         GBTextBoxFlexibleDimensionHeight;
static CGFloat const kDefaultIconVerticalOffset =                           0;
static CGFloat const kDefaultIconLeftMargin =                               0;
static CGFloat const kDefaultRightIconVerticalOffset =                      0;
static CGFloat const kDefaultRightIconRightMargin =                         0;
static NSTextAlignment const kDefaultTextAlignment =                        NSTextAlignmentCenter;
static UIEdgeInsets const kDefaultTextPadding =                             (UIEdgeInsets){0, 0, 0, 0};
static CGSize const kDefaultTextShadowOffset =                              (CGSize){0, 0};
#define kDefaultFont                                                        [UIFont fontWithName:@"HelveticaNeue-Medium" size:12]
#define kDefaultColor                                                       [UIColor colorWithWhite:0.8 alpha:1]
#define kDefaultShadowColor                                                 [UIColor clearColor];


@interface GBTextBox ()

@property (strong, nonatomic) UIImageView                                   *iconImageView;
@property (strong, nonatomic) UIImageView                                   *rightIconImageView;
@property (strong, nonatomic) UIImageView                                   *backgroundImageView;
@property (strong, nonatomic) UILabel                                       *textLabel;

@property (assign, nonatomic) CGSize                                        previousSize;

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

-(void)setFlexibleDimension:(GBTextBoxFlexibleDimension)flexibleDimension {
    _flexibleDimension = flexibleDimension;
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
    _iconVerticalOffset = kDefaultIconVerticalOffset;
    _iconLeftMargin = kDefaultIconLeftMargin;
    self.textLabel.font = kDefaultFont;
    self.textLabel.textColor = kDefaultColor;
    self.textLabel.shadowColor = kDefaultShadowColor;
    self.textLabel.shadowOffset = kDefaultTextShadowOffset;
    self.textLabel.textAlignment = kDefaultTextAlignment;
    _textPadding = kDefaultTextPadding;
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
    //commit the new frame
    self.frame = [self _dynamicSelfFrame];

    //resize and reposition the label
    self.textLabel.frame = [self _dynamicLabelFrame];
    
    //tell the delegate what happened
    CGSize newSize = self.frame.size;
    
    //let the delegate know if we changed our width
    if (!CGSizeEqualToSize(self.previousSize, newSize)) {
        if ([self.delegate respondsToSelector:@selector(textBox:didChangeSizeFrom:to:)]) {
            [self.delegate textBox:self didChangeSizeFrom:self.previousSize to:newSize];
        }
        
        //remember it so we can check if its changed in the future
        self.previousSize = newSize;
    }
    
    //update the icon too, sometimes the autoresizing mask fails if we started from a zero or negative height
    [self _handleIconGeometry];
}

-(CGRect)_dynamicSelfFrame {
    CGSize selfSize;
    switch (self.flexibleDimension) {
        case GBTextBoxFlexibleDimensionHeight: {
            selfSize = CGSizeMake(self.frame.size.width,
                                  [self.textLabel sizeThatFits:CGSizeMake([self _seedLabelWidth], CGFLOAT_MAX)].height + (self.textPadding.top + self.textPadding.bottom));
        } break;
            
        case GBTextBoxFlexibleDimensionWidth: {
            CGSize size = [self.textLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, [self _seedLabelHeight])];
            selfSize = CGSizeMake(size.width + (self.textPadding.left + self.textPadding.right),
                                  self.frame.size.height);
        } break;
    }
    
    return CGRectMake(self.frame.origin.x, self.frame.origin.y, selfSize.width, selfSize.height);
}


-(CGRect)_dynamicLabelFrame {
    CGSize labelSize;
    switch (self.flexibleDimension) {
        case GBTextBoxFlexibleDimensionHeight: {
            labelSize = CGSizeMake([self _seedLabelWidth],
                                   [self.textLabel sizeThatFits:CGSizeMake([self _seedLabelWidth], CGFLOAT_MAX)].height);
        } break;
            
        case GBTextBoxFlexibleDimensionWidth: {
            labelSize = CGSizeMake([self.textLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, [self _seedLabelHeight])].width,
                                   [self _seedLabelHeight]);
        } break;
    }
    
    return CGRectMake(self.textPadding.left, self.textPadding.top, labelSize.width, labelSize.height);
}

-(CGFloat)_dynamicLabelDimensionLength {
    CGSize labelSize;
    switch (self.flexibleDimension) {
        case GBTextBoxFlexibleDimensionHeight: {
            labelSize = [self.textLabel sizeThatFits:CGSizeMake([self _seedLabelWidth], CGFLOAT_MAX)];
        } break;
            
        case GBTextBoxFlexibleDimensionWidth: {
            labelSize = [self.textLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, [self _seedLabelHeight])];
        } break;
    }
    
    return labelSize.height;
}

-(CGFloat)_seedLabelWidth {
    return self.bounds.size.width - (self.textPadding.left + self.textPadding.right);
}

-(CGFloat)_seedLabelHeight {
    return self.bounds.size.height - (self.textPadding.top + self.textPadding.bottom);
}

@end
