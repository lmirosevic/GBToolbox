//
//  GBAlertBadgeView.h
//  Russia
//
//  Created by Luka Mirosevic on 01/07/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBAlertBadgeView : UIView

@property (copy, nonatomic) NSString        *badgeText;
@property (copy, nonatomic) UIFont          *font;
@property (copy, nonatomic) UIColor         *textColor;
@property (strong, nonatomic) UIImage       *backgroundImage;
@property (assign, nonatomic) CGFloat       height;
@property (assign, nonatomic) CGFloat       horizontalPadding;

+(GBAlertBadgeView *)badgeWithHeight:(CGFloat)height font:(UIFont *)font textColor:(UIColor *)textColor backgroundImage:(UIImage *)backgroundImage  horizontalPadding:(CGFloat)horizontalPadding;
-(id)initWithHeight:(CGFloat)height font:(UIFont *)font textColor:(UIColor *)textColor backgroundImage:(UIImage *)backgroundImage horizontalPadding:(CGFloat)horizontalPadding;

-(void)syncFrameWithView:(UIView *)view offset:(CGPoint)offset;
-(void)stopSyncingFrame;

@end