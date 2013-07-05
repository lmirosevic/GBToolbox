//
//  NotificationView.h
//  Russia
//
//  Created by Luka Mirosevic on 05/07/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NotificationViewDelegate;

@interface GBTextBox : UIView

@property (weak, nonatomic) id<NotificationViewDelegate>    delegate;

@property (strong, nonatomic) UIImage                       *icon;
@property (assign, nonatomic) CGFloat                       iconLeftMargin;
@property (assign, nonatomic) CGFloat                       iconVerticalOffset;
@property (strong, nonatomic) UIImage                       *backgroundImage;
@property (strong, nonatomic) NSString                      *text;
@property (strong, nonatomic) UIColor                       *textColor;
@property (strong, nonatomic) UIColor                       *textShadowColor;
@property (assign, nonatomic) CGSize                        textShadowOffset;
@property (strong, nonatomic) UIFont                        *font;
@property (assign, nonatomic) NSTextAlignment               textAlignment;
@property (assign, nonatomic) UIEdgeInsets                  textPadding;

//forces it to recalculate the height based on the current text and it's properties. you would call this after you set the frame of this view so that it recalculated it's own height
-(void)recalculateHeight;

@end

@protocol NotificationViewDelegate <NSObject>
@optional

-(void)notificationView:(GBTextBox *)notificationView didChangeRequiredHeightTo:(CGFloat)newHeight;

@end