//
//  GBTextBox.h
//  Russia
//
//  Created by Luka Mirosevic on 05/07/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GBTextBoxFlexibleDimensionHeight,
    GBTextBoxFlexibleDimensionWidth
} GBTextBoxFlexibleDimension;

@protocol GBTextBoxDelegate;

@interface GBTextBox : UIView

@property (weak, nonatomic) id<GBTextBoxDelegate>               delegate;

@property (assign, nonatomic) GBTextBoxFlexibleDimension        flexibleDimension;//defaults to height
@property (strong, nonatomic) UIImage                           *icon;
@property (assign, nonatomic) CGFloat                           iconLeftMargin;
@property (assign, nonatomic) CGFloat                           iconVerticalOffset;
@property (strong, nonatomic) UIImage                           *rightIcon;
@property (assign, nonatomic) CGFloat                           rightIconRightMargin;
@property (assign, nonatomic) CGFloat                           rightIconVerticalOffset;
@property (strong, nonatomic) UIImage                           *backgroundImage;
@property (strong, nonatomic) NSString                          *text;
@property (strong, nonatomic) UIColor                           *textColor;
@property (strong, nonatomic) UIColor                           *textShadowColor;
@property (assign, nonatomic) CGSize                            textShadowOffset;
@property (strong, nonatomic) UIFont                            *font;
@property (assign, nonatomic) NSTextAlignment                   textAlignment;
@property (assign, nonatomic) UIEdgeInsets                      textPadding;

//forces it to recalculate the height based on the current text and it's properties. you would call this after you set the frame of this view so that it recalculated it's own height
-(void)recalculateHeight;

@end

@protocol GBTextBoxDelegate <NSObject>
@optional

-(void)textBox:(GBTextBox *)textBox didChangeSizeFrom:(CGSize)oldSize to:(CGSize)newSize;

@end