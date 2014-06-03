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
#import <CoreLocation/CoreLocation.h>

@class GBAddress;

@interface GBToolbox (iOS)

#pragma mark - UIView

NSUInteger tagFromUIViewSubclass(id sender);

#pragma mark - View Hierarchy

UIViewController * TopmostViewController();
UIViewController * TopmostViewControllerWithRootViewController(UIViewController *rootViewController);

#pragma mark - Screen Locking

+(BOOL)isAutoScreenLockingEnabled;
+(void)enableAutoScreenLocking:(BOOL)enable;

#pragma mark - App Store redirect

void RedirectToAppStore(NSString *appID);

#pragma mark - Images

UIImage * Image(NSString *name);
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

#pragma mark - Colors

//Returns a random color with a bias towards the more saturated and brighter colors
UIColor *RandomColor();

#pragma mark - Auto Layout

void AutoLayoutDebugOn(BOOL crashOnTrigger);
NSString *AutoLayoutViewPointer(NSObject *object);
NSDictionary *AutoLayoutPointerViewsDictionaryForViews(NSArray *views);

#pragma mark - Geocoding

void ReverseGeocodeLocation(CLLocation *location, VoidBlockObject block);

#pragma mark - UIViewController containment

void AddChildViewController(UIViewController *hostViewController, UIViewController *childViewController);
void AddChildViewControllerToView(UIViewController *hostViewController, UIView *hostView, UIViewController *childViewController);
void RemoveChildViewController(UIViewController *childViewController);

@end

@interface GBAddress : NSObject

@property (copy, nonatomic) NSString *street;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *zip;
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *countryCode;
@property (copy, nonatomic) NSString *state;

@end
