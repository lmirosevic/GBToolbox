//
//  GBAlertBadge.h
//  GBToolBox
//
//  Created by Luka Mirosevic on 10/10/2016.
//  Copyright © 2016 Goonbee e.U. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 The classic alert badge with a number/string inside it.
 
 Useful for signalling things that have unread notifications or similar.
 */
@interface GBAlertBadge : UIView

@property (copy, nonatomic, nullable) NSString          *badgeText;
@property (assign, nonatomic) NSInteger                 badgeCount;
@property (strong, nonatomic, nonnull) UIFont           *font;
@property (strong, nonatomic, nonnull) UIColor          *textColor;
@property (strong, nonatomic, nullable) UIImage         *backgroundImage;
@property (assign, nonatomic) UIEdgeInsets              padding;
@property (assign, nonatomic) BOOL                      hidesWhenCountZero;//default: NO
@property (assign, nonatomic) BOOL                      clipsToPillShape;//default: YES

/**
 Creates a badge with a background color and clipped to a pill shape.
 */
+ (nonnull instancetype)badgeWithFont:(nonnull UIFont *)font textColor:(nonnull UIColor *)textColor backgroundColor:(nonnull UIColor *)backgroundColor padding:(UIEdgeInsets)padding;

/**
 Creates a badge with a background image.
 */
+ (nonnull instancetype)badgeWithFont:(nonnull UIFont *)font textColor:(nonnull UIColor *)textColor backgroundImage:(nullable UIImage *)backgroundImage padding:(UIEdgeInsets)padding;
- (nonnull instancetype)initWithFont:(nonnull UIFont *)font textColor:(nonnull UIColor *)textColor backgroundImage:(nullable UIImage *)backgroundImage padding:(UIEdgeInsets)padding;

@end
