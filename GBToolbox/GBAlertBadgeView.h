//
//  GBAlertBadgeView.h
//  Russia
//
//  Created by Luka Mirosevic on 01/07/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 The classic alert badge with a number/string inside it.
 
 Useful for signalling things that have unread notifications or similar.
 */
__deprecated_msg("Deprecated since 21.7. Use GBAlertBadgeView2 instead.")
@interface GBAlertBadgeView : UIView

@property (copy, nonatomic) NSString        *badgeText NS_AVAILABLE_IOS(7_0);
@property (assign, nonatomic) NSInteger     badgeCount NS_AVAILABLE_IOS(7_0);
@property (copy, nonatomic) UIFont          *font NS_AVAILABLE_IOS(7_0);
@property (copy, nonatomic) UIColor         *textColor NS_AVAILABLE_IOS(7_0);
@property (strong, nonatomic) UIImage       *backgroundImage NS_AVAILABLE_IOS(7_0);
@property (assign, nonatomic) CGFloat       height NS_AVAILABLE_IOS(7_0);
@property (assign, nonatomic) CGFloat       horizontalPadding NS_AVAILABLE_IOS(7_0);
@property (assign, nonatomic) BOOL          hidesWhenCountZero NS_AVAILABLE_IOS(7_0);//default: NO

+ (GBAlertBadgeView *)badgeWithHeight:(CGFloat)height font:(UIFont *)font textColor:(UIColor *)textColor backgroundImage:(UIImage *)backgroundImage horizontalPadding:(CGFloat)horizontalPadding NS_AVAILABLE_IOS(7_0);
- (id)initWithHeight:(CGFloat)height font:(UIFont *)font textColor:(UIColor *)textColor backgroundImage:(UIImage *)backgroundImage horizontalPadding:(CGFloat)horizontalPadding NS_AVAILABLE_IOS(7_0);

- (void)syncFrameWithView:(UIView *)view offset:(CGPoint)offset NS_AVAILABLE_IOS(7_0) __deprecated_msg("Deprecated since 21.7. Use Autolayout instead.");
- (void)stopSyncingFrame NS_AVAILABLE_IOS(7_0) __deprecated_msg("Deprecated since 21.7. When using Autolayout this should no longer be called.");

@end
