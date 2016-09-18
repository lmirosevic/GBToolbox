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
#import "UIControl+GBToolbox.h"

#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@class GBAddress;

@interface GBToolbox (iOS)

#pragma mark - UIView

NSUInteger tagFromUIViewSubclass(_Nullable id sender);

#pragma mark - View Hierarchy

UIViewController * _Nullable TopmostViewController();
UIViewController * _Nullable TopmostViewControllerWithRootViewController(UIViewController * _Nullable rootViewController);

#pragma mark - Screen Locking

+(BOOL)isAutoScreenLockingEnabled;
+(void)enableAutoScreenLocking:(BOOL)enable;

#pragma mark - Torch

/**
 Enables or disables the device's flash/torch if the device has one
 */
void EnableTorch(BOOL enable);

#pragma mark - App Store redirect

void RedirectToAppStore(NSString * _Nonnull appID);

#pragma mark - Images

UIImage * _Nullable Image(NSString * _Nonnull name);
UIImage * _Nullable ImageResizableWithCapInsets(NSString * _Nonnull name, CGFloat topCap, CGFloat leftCap, CGFloat bottomCap, CGFloat rightCap);

#pragma mark - Clipping

CAShapeLayer * _Nonnull RoundClippingMaskInRectWithMargin(CGRect rect, UIEdgeInsets margin);
UIBezierPath * _Nonnull RoundBezierPathForRectWithMargin(CGRect rect, UIEdgeInsets margin);

#pragma mark - Push Notifications

BOOL IsPushDisabled();

#pragma mark - UITableView

BOOL IsCellAtIndexPathFullyVisible(NSIndexPath * _Nullable indexPath, UITableView * _Nullable tableView);

#pragma mark - Keyboard hiding

void DismissKeyboard();

#pragma mark - Twitter

BOOL IsTwitterAccountAvailable();

#pragma mark - Localisation

NSString * _Nullable UIKitLocalizedString(NSString * _Nullable string);

#pragma mark - Vibration

void VibrateDevice();

#pragma mark - Colors

//Returns a random color with a bias towards the more saturated and brighter colors
UIColor * _Nonnull RandomColor();

#pragma mark - Auto Layout

void AutoLayoutDebugOn(BOOL crashOnTrigger);
NSString * _Nonnull AutoLayoutViewPointer(NSObject * _Nonnull object);
NSDictionary * _Nonnull AutoLayoutPointerViewsDictionaryForViews(NSArray * _Nonnull views);

#pragma mark - Debugging

void DebugCode(VoidBlock code);

UIButton *RegisterDebugButton(NSString *title, GBActionBlock action);

#pragma mark - Geocoding

void ReverseGeocodeLocation(CLLocation * _Nullable location, void(^_Nullable block)(GBAddress * _Nullable address));

#pragma mark - UIViewController containment

void AddChildViewController(UIViewController * _Nonnull hostViewController, UIViewController * _Nonnull childViewController);
void AddChildViewControllerToView(UIViewController * _Nonnull hostViewController, UIView * _Nonnull hostView, UIViewController * _Nonnull childViewController);
void RemoveChildViewController(UIViewController * _Nonnull childViewController);

#pragma mark - Actions

void OpenLinkInSafari(NSString * _Nullable link);
void OpenMap(CLLocation * _Nonnull location, NSString * _Nullable name);
void CallPhone(NSString * _Nonnull number);
void SendSMS(NSString * _Nonnull number);

#pragma mark - Fonts

void ListAvailableFonts();

#pragma mark - Disk utils

NSString * _Nonnull DocumentsDirectoryPath();
NSURL * _Nonnull DocumentsDirectoryURL();

#pragma mark - Cookies

void ClearCookies();

#pragma mark - Email

void ShowContactEmailOnViewController(UIViewController * _Nonnull viewController,  NSArray<NSString *> * _Nullable toAdresses,  NSString * _Nullable subject,  NSString * _Nullable body);

#pragma mark - Alerts

void ShowAlert(NSString * _Nullable title, NSString * _Nullable message, NSString * _Nullable dismissButtonTitle);

@end

