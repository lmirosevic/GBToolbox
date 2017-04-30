//
//  GBUtility_iOS.m
//  GBToolbox
//
//  Created by Luka Mirosevic on 05/02/2013.
//  Copyright (c) 2013 Luka Mirosevic. All rights reserved.
//

#import "GBUtility_iOS.h"

#import "GBMacros_Common.h"
#import "NSObject+GBToolbox.h"
#import "NSArray+GBToolbox.h"
#import "NSString+GBToolbox.h"

#import "GBAddress.h"

#import <Foundation/Foundation.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AddressBook/AddressBook.h>
#import <MapKit/MapKit.h>
#import <AVFoundation/AVFoundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>

/**
 Class that gives us some storage and that we can use as a delegate
 */
@interface EmailDelegateStorage<MFMailComposeViewControllerDelegate> : NSObject

@property (nonatomic, weak) UIViewController *viewControllerForEmailWindow;

@end

@implementation EmailDelegateStorage

_singleton(sharedStorage)

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result == MFMailComposeResultFailed) {
        ShowAlert(nil, @"Mail could not be sent. Please check your internet connection.", @"OK");
    }
    
    [self.viewControllerForEmailWindow dismissViewControllerAnimated:YES completion:nil];
    self.viewControllerForEmailWindow = nil;
}

@end


@implementation GBToolbox (iOS)

#pragma mark - UIView

NSUInteger tagFromUIViewSubclass(id sender) {
    if ([sender isKindOfClass:[UIView class]]) {
        return ((UIView *)sender).tag;
    }
    else return 0;
}

#pragma mark - View Hierarchy

UIViewController * TopmostViewController() {
    return TopmostViewControllerWithRootViewController([UIApplication sharedApplication].keyWindow.rootViewController);
}

UIViewController * TopmostViewControllerWithRootViewController(UIViewController *rootViewController) {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return TopmostViewControllerWithRootViewController(tabBarController.selectedViewController);
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return TopmostViewControllerWithRootViewController(navigationController.visibleViewController);
    }
    else if (rootViewController.presentedViewController) {
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return TopmostViewControllerWithRootViewController(presentedViewController);
    }
    else {
        return rootViewController;
    }
}

#pragma mark - Screen Locking

+(BOOL)isAutoScreenLockingEnabled {
	UIApplication *me = [UIApplication sharedApplication];
	return me.idleTimerDisabled;
}

+(void)enableAutoScreenLocking:(BOOL)enable {
	UIApplication *me = [UIApplication sharedApplication];
	me.idleTimerDisabled = !enable;
}

#pragma mark - Torch

void EnableTorch(BOOL enable) {
    // check if flashlight available
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            [device lockForConfiguration:nil];
            if (enable) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}

#pragma mark - App Store redirect

void RedirectToAppStore(NSString *appID) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?mt=8", appID]]];
}

#pragma mark - Images

UIImage * Image(NSString *name) {
    return [UIImage imageNamed:name];
}

UIImage * ImageResizableWithCapInsets(NSString *name, CGFloat topCap, CGFloat leftCap, CGFloat bottomCap, CGFloat rightCap) {
    return [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(topCap, leftCap, bottomCap, rightCap)];
}

#pragma mark - Clipping

CAShapeLayer * RoundClippingMaskInRectWithMargin(CGRect rect, UIEdgeInsets margin) {
    UIBezierPath *bezierPath = RoundBezierPathForRectWithMargin(rect, margin);
    
    CAShapeLayer *shapeMask = [CAShapeLayer new];
    shapeMask.frame = rect;
    shapeMask.path = bezierPath.CGPath;
    
    return shapeMask;
}

UIBezierPath * RoundBezierPathForRectWithMargin(CGRect rect, UIEdgeInsets margin) {
    return [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.origin.x + margin.left,
                                                             rect.origin.y + margin.top,
                                                             rect.size.width - (margin.left + margin.right),
                                                             rect.size.height - (margin.top + margin.bottom))];
}

#pragma mark - Push Notifications

BOOL IsPushDisabled() {
// iOS 8+ deployment target, so we can use the simple case
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
    return [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
// Older dpeloyment target, so we want to choose the correct method at runtime
#else
    //iOS 8+
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
        return [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
    }
    //iOS 7 and below
    else {
        return [[UIApplication sharedApplication] enabledRemoteNotificationTypes] == UIRemoteNotificationTypeNone;
    }
#endif
}

#pragma mark - UITableView

BOOL IsCellAtIndexPathFullyVisible(NSIndexPath *indexPath, UITableView *tableView) {
    CGRect cellRect = [tableView rectForRowAtIndexPath:indexPath];
    cellRect = [tableView convertRect:cellRect toView:tableView.superview];
    return CGRectContainsRect(tableView.frame, cellRect);
}

#pragma mark - Keyboard hiding

void DismissKeyboard() {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - Twitter

BOOL IsTwitterAccountAvailable() {
#if TARGET_IPHONE_SIMULATOR
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //Suppressing deprecation warning as this is only used for the Simulator, and only so to work around a Simulator bug
    return [TWTweetComposeViewController canSendTweet];
#pragma clang diagnostic pop
#else
    if (IsClassAvailable(SLComposeViewController)) {
        return [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
    }
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [TWTweetComposeViewController canSendTweet];
#pragma clang diagnostic pop
    }
#endif
}

#pragma mark - Localisation

NSString * UIKitLocalizedString(NSString *string) {
	NSBundle *UIKitBundle = [NSBundle bundleForClass:[UIApplication class]];
    NSString *localizedString = [UIKitBundle localizedStringForKey:string value:string table:nil];
    
    return localizedString ?: string;
}

#pragma mark - Vibration

void VibrateDevice() {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

#pragma mark - Colors

//Returns a random color with a bias towards the more saturated and brighter colors
UIColor *RandomColor() {
    CGFloat hue = Random();
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

#pragma mark - Auto Layout

void AutoLayoutDebugOn(BOOL crashOnTrigger) {
    UIWindow *keyWindow = [UIWindow performSelector:@selector(keyWindow)];
    if (keyWindow.hasAmbiguousLayout) {
        // we're calling a private method here so we need to do some trickery to avoid a compiler warning
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSLog(@"%@", [keyWindow performSelector:NSSelectorFromString(@"_autolayoutTrace")]);
#pragma clang diagnostic pop
        
        if (crashOnTrigger) {
            NSCAssert(false, @"Checking Autolayout... AMBIGUOUS!!!");
        }
        else {
            NSLog(@"Checking Autolayout... AMBIGUOUS!!!");
        }
    }
    else {
        NSLog(@"Checking Autolayout... OK");
    }
}

NSString *AutoLayoutViewPointer(NSObject *object) {
    return [NSString stringWithFormat:@"_%@", object.pointerAddress];
}

NSDictionary *AutoLayoutPointerViewsDictionaryForViews(NSArray *views) {
    return [NSDictionary dictionaryWithObjects:views forKeys:[views map:^id(id object) {
        // ...We need a unique string that points to the selected object. Sounds a bit like a pointer, so... why don't we use a pointer, just stringified, courtesy of a little utility  function.
        return AutoLayoutViewPointer(object);
    }]];
}

#pragma mark - Debugging

void DebugCode(VoidBlock code) {
#ifdef DEBUG
    code();
#endif
}

#ifdef DEBUG
static NSInteger GBToolboxDebugButtonCount = 0;
#endif
UIButton *RegisterDebugButton(NSString *title, GBActionBlock action) {
#ifdef DEBUG
    CGFloat inset = 20;
    CGSize buttonSize = CGSizeMake(40, 20);
    CGFloat buttonSpacing = 4;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.minimumScaleFactor = 0.5;
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    button.alpha = 0.5;
    [button addTargetActionForControlEvents:UIControlEventTouchUpInside withBlock:action];
    [window addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    CGSize distance = CGSizeMake(
                                 GBToolboxDebugButtonCount * (buttonSize.width + buttonSpacing) + inset,
                                 inset
                                 );
    [window addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button(==size)]-(distance)-|" options:0 metrics:@{@"size": @(buttonSize.width), @"distance": @(distance.width)} views:NSDictionaryOfVariableBindings(button)]];
    [window addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(==size)]-(distance)-|" options:0 metrics:@{@"size": @(buttonSize.height), @"distance": @(distance.height)} views:NSDictionaryOfVariableBindings(button)]];
    
    GBToolboxDebugButtonCount += 1;
    
    return button;
#else
    return nil;
#endif
}

#pragma mark - Geocoding

void ReverseGeocodeLocation(CLLocation *location, void(^block)(GBAddress *address)) {
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        GBAddress *address;
        
        if (placemarks && placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            NSDictionary *addressDictionary = placemark.addressDictionary;
            
            address = [GBAddress new];
            address.street = addressDictionary[@"Street"];
            address.city = addressDictionary[@"City"];
            address.postCode = addressDictionary[@"ZIP"];
            address.country = addressDictionary[@"Country"];
            address.countryCode = addressDictionary[@"CountryCode"];
            address.state = addressDictionary[@"State"];
        }
        
        if (block) block(address);
    }];
}

#pragma mark - UIViewController containment

void AddChildViewController(UIViewController *hostViewController, UIViewController *childViewController) {
    AddChildViewControllerToView(hostViewController, hostViewController.view, childViewController);
}

void AddChildViewControllerToView(UIViewController *hostViewController, UIView *hostView, UIViewController *childViewController) {
    [hostViewController addChildViewController:childViewController];
    [hostView addSubview:childViewController.view];
    [childViewController didMoveToParentViewController:hostViewController];
}

void RemoveChildViewController(UIViewController *childViewController) {
    [childViewController willMoveToParentViewController:nil];
    [childViewController.view removeFromSuperview];
    [childViewController removeFromParentViewController];
}

#pragma mark - Actions

void OpenLinkInSafari(NSString *link) {
    NSString *urlString = link;

    // add protocol if it's not there yet
    if (![urlString containsSubstring:@"://"]) {
        urlString = [NSString stringWithFormat:@"http://%@", urlString];
    }

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

void OpenMap(CLLocation *location, NSString *name) {
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:location.coordinate addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    if (name) mapItem.name = name;
    
    [mapItem openInMapsWithLaunchOptions:nil];
}

static void _performPhoneNumberActionWithNumber(NSString *number, NSString *prefix) {
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789+"] invertedSet];
    NSString *processedNumber = [[number componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
    NSString *urlString = [NSString stringWithFormat:@"%@://%@", prefix, processedNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

void CallPhone(NSString *number) {
    _performPhoneNumberActionWithNumber(number, @"tel");
}

void SendSMS(NSString *number) {
    _performPhoneNumberActionWithNumber(number, @"sms");
}

#pragma mark - Fonts

void ListAvailableFonts() {
    for (NSString *fontFamily in [UIFont familyNames]) {
        NSLog(@"%@: %@", fontFamily, [UIFont fontNamesForFamilyName:fontFamily]);
    }
}

#pragma mark - Disk utils

NSString * DocumentsDirectoryPath() {
#if TARGET_OS_IPHONE
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
#else
    NSString *documentsDirectory = [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"]];
#endif
    
    return documentsDirectory;
}

NSURL * DocumentsDirectoryURL() {
    return [NSURL fileURLWithPath:DocumentsDirectoryPath()];
}

#pragma mark - Cookies

void ClearCookies() {
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Email

void ShowContactEmailOnViewController( UIViewController * _Nonnull viewController,  NSArray<NSString *> * _Nullable toAdresses,  NSString * _Nullable subject,  NSString * _Nullable body) {
    AssertParameterNotNil(viewController);
    
    if ([MFMailComposeViewController canSendMail]) {
        [EmailDelegateStorage sharedStorage].viewControllerForEmailWindow = viewController;
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = (id<MFMailComposeViewControllerDelegate>)[EmailDelegateStorage sharedStorage];
        if (subject) [mailViewController setSubject:subject];
        if (toAdresses) [mailViewController setToRecipients:toAdresses];
        if (body) [mailViewController setMessageBody:body isHTML:NO];
        
        [viewController presentViewController:mailViewController animated:YES completion:nil];
    } else {
        ShowAlert(@"Mail Settings", @"Please set up an email account in the Settings app", @"OK");
    }
}

#pragma mark - Alerts

void ShowAlert(NSString * _Nullable title, NSString * _Nullable message, NSString * _Nullable dismissButtonTitle) {
    // iOS 8+
    if (UIAlertController.class) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        if (dismissButtonTitle) [alert addAction:[UIAlertAction actionWithTitle:dismissButtonTitle style:UIAlertActionStyleDefault handler:nil]];
        [TopmostViewController() presentViewController:alert animated:YES completion:nil];
    }
    // iOS 7 and below
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:dismissButtonTitle otherButtonTitles:nil] show];
    }
#pragma clang diagnostic pop
}

#pragma mark - Network

// http://stackoverflow.com/questions/5198716/iphone-get-ssid-without-private-library/14288648#14288648
NSString *CurrentWifiNetworkName() {
    NSString *wifiName = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info[@"SSID"]) {
            wifiName = info[@"SSID"];
        }
    }
    return wifiName;
}

@end
