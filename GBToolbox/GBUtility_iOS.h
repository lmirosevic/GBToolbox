//
//  GBUtility_iOS.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBTypes_Common.h"
#import "GBTypes_iOS.h"

#import "GBUtility_Common.h"

#import <QuartzCore/QuartzCore.h>

@interface GBToolbox (iOS)

#pragma mark - UIView

NSUInteger tagFromUIViewSubclass(id sender);

#pragma mark - Screen Locking

+(BOOL)isAutoScreenLockingEnabled;
+(void)enableAutoScreenLocking:(BOOL)enable;

#pragma mark - App Store redirect

void RedirectToAppStore(NSString *appID);

#pragma mark - Images

UIImage * ImageResizableWithCapInsets(NSString *name, CGFloat topCap, CGFloat leftCap, CGFloat bottomCap, CGFloat rightCap);

#pragma mark - Clipping

CAShapeLayer * RoundClippingMaskInRectWithMargin(CGRect rect, UIEdgeInsets margin);
UIBezierPath * RoundBezierPathForRectWithMargin(CGRect rect, UIEdgeInsets margin);

#pragma mark - Push Notifications

BOOL IsPushDisabled();

#pragma mark - UITableView

BOOL IsCellAtIndexPathFullyVisible(NSIndexPath *indexPath, UITableView *tableView);

#pragma mark - Keyboard hiding

void DismissKeyboard();

#pragma mark - Twitter

BOOL IsTwitterAccountAvailable();

#pragma mark - Localisation

NSString * UIKitLocalizedString(NSString *string);

#pragma mark - Vibration

void VibrateDevice();

@end
