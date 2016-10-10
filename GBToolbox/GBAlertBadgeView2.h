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
@interface GBAlertBadgeView2 : UIView

@property (copy, nonatomic, nullable) NSString          *badgeText;
@property (assign, nonatomic) NSInteger                 badgeCount;
@property (strong, nonatomic, nonnull) UIFont           *font;
@property (strong, nonatomic, nonnull) UIColor          *textColor;
@property (strong, nonatomic, nullable) UIImage         *backgroundImage;
@property (assign, nonatomic) UIEdgeInsets              padding;
@property (assign, nonatomic) BOOL                      hidesWhenCountZero;//default: NO
@property (assign, nonatomic) BOOL                      clipsToPillShape;//default: YES

+ (nonnull instancetype)badgeWithFont:(nonnull UIFont *)font textColor:(nonnull UIColor *)textColor backgroundImage:(nullable UIImage *)backgroundImage padding:(UIEdgeInsets)padding;
- (nonnull instancetype)initWithFont:(nonnull UIFont *)font textColor:(nonnull UIColor *)textColor backgroundImage:(nullable UIImage *)backgroundImage padding:(UIEdgeInsets)padding;

@end
